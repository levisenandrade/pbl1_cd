module Main(a, b, c, d, e, f, g, S, Hsync, Vsync, R, G, Blue, CLK, A, B, C, D, Slc0, Slc1);

	input A, B, C, D, Slc0, Slc1, CLK;
	output a, b, c, d, e, f, g, Hsync, Vsync;
	output [7:0]S;	
	output [3:0]R;
   output [3:0]G;
   output [3:0]Blue;
   wire clkDiv;
	
	
	wire [3:0]T;
	wire [4:0]M;
	wire Alt, Inv, Prg;
	
	Logic L0(.S(T), .A(A), .B(B), .C(C), .D(D));
	
	Mux4inp4bits Mux0(
	.S(M), 
	.A({1'b0, T[3], T[2], T[1], T[0]}), 
	.B({1'b1, A, B, C, D}), 
	.C(4'b01001), 
	.D(4'b01000), 
	.Slc0(Slc0), 
	.Slc1(Slc1));
	
	Conversor C0(.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .A(M[4]), .B(M[3]), .C(M[2]), .D(M[1]), .E(M[0]));
	
	LogicaLEDs Log0(
	.Alt(Alt), 
	.Inv(Inv), 
	.Prg(Prg), 
	.A(M[3]), 
	.B(M[2]), 
	.C(M[1]), 
	.D(M[0]));

	Mux4inp8bits Mux1(
	.S(S), 
	.A({1'b0, Prg, Inv, Alt, 1'b0, 1'b0, 1'b0, 1'b0}), 
	.B({1'b0, 1'b0, 1'b0, 1'b0, A, B, C, D}), 
	.C(8'b10000000), 
	.D(8'b01000000), 
	.Slc0(Slc0), 
	.Slc1(Slc1));
	
	// --- 1. CLOCK ---
    DivFreq Div(.S(clkDiv), .Clk(CLK));
    
    // --- 2. CONTADORES SÍNCRONOS ---
    wire rst_n_h, clk_v_estavel, h_sync_raw, v_sync_raw, h_sync_clean, v_sync_clean; 
	 wire [9:0]Cordy;
	 wire [9:0]Cordx;
	 
    ContadorHsync ContHsync(
	 .clk(clkDiv), 
	 .q(Cordx), 
	 .rst_n(rst_n_h));
    
    not gate_v_clk (clk_v_estavel, Cordx[9]);
	 
    ContadorVsync ContVsync(
	 .clk(clk_v_estavel),
	 .q(Cordy)); 

    // --- 3. SINCRONISMO COM LIMPEZA ---
	 
    CriarBloco HSYNC_GEN(
	 .S(h_sync_raw), 
	 .A(Cordx), 
	 .ConstMin(10'd656), 
	 .ConstMax(10'd751));
	 
    CriarBloco VSYNC_GEN(
	 .S(v_sync_raw), 
	 .A(Cordy), 
	 .ConstMin(10'd490), 
	 .ConstMax(10'd491));
	 
    FlipFlopD FF_HSYNC (.d(h_sync_raw), .clk(clkDiv), .rst_n(1'b1), .q(h_sync_clean));
    FlipFlopD FF_VSYNC (.d(v_sync_raw), .clk(clkDiv), .rst_n(1'b1), .q(v_sync_clean));
	 
    not (Hsync, h_sync_clean);
    not (Vsync, v_sync_clean);
    
    // =========================================================
    // --- 4. SPRITES E JANELAS (BLANKING) ---
    // =========================================================
    
    // --- SENSOR A (PESSOA) ---
    wire Blka0, Blka1, VidA, VidBlkA, pixA;
	 
    wire [15:0] rowA;
	 
    CriarBloco BLANK_H (
	 .S(Blka0), 
	 .A(Cordx), 
	 .ConstMin(10'd0), 
	 .ConstMax(10'd15));
	 
    CriarBloco BLANK_V (
	 .S(Blka1), 
	 .A(Cordy), 
	 .ConstMin(10'd0), 
	 .ConstMax(10'd15));
	 
    Sprite_Gas R_A (.address_y(Cordy[3:0]), .row_data(rowA));
	 
    assign pixA = rowA[4'd15 - Cordx[3:0]];
	 
    and (VidA, Blka0, Blka1);
	 
    FlipFlopD FF_VIDEO0 (.d(VidA), .clk(clkDiv), .rst_n(1'b1), .q(VidBlkA));

    // --- SENSOR B (TEMPERATURA) ---
    wire Blkb0, Blkb1, VidB, VidBlkB, pixB;
    wire [15:0] rowB;
	 
    CriarBloco BLANKB_H (
	 .S(Blkb0), 
	 .A(Cordx), 
	 .ConstMin(10'd32), 
	 .ConstMax(10'd47));
	 
    CriarBloco BLANKB_V (
	 .S(Blkb1), 
	 .A(Cordy), 
	 .ConstMin(10'd0), 
	 .ConstMax(10'd15));
	 
    Sprite_Temp R_B (.address_y(Cordy[3:0]), .row_data(rowB));
	 
    assign pixB = rowB[4'd15 - Cordx[3:0]];
	 
    and (VidB, Blkb0, Blkb1);
	 
    FlipFlopD FF_VIDEO1 (.d(VidB), .clk(clkDiv), .rst_n(1'b1), .q(VidBlkB));
     
    // --- SENSOR C (GÁS) ---
	 
    wire Blkc0, Blkc1, VidC, VidBlkC, pixC;
    wire [15:0] rowC;
	 
    CriarBloco BLANKC_H (
	 .S(Blkc0), 
	 .A(Cordx), 
	 .ConstMin(10'd64), 
	 .ConstMax(10'd79));
	 
    CriarBloco BLANKC_V (
	 .S(Blkc1), 
	 .A(Cordy), 
	 .ConstMin(10'd0), 
	 .ConstMax(10'd15));
	 
    Sprite_Pessoa R_C (.address_y(Cordy[3:0]), .row_data(rowC));
	 
    assign pixC = rowC[4'd15 - Cordx[3:0]];
    and (VidC, Blkc0, Blkc1);
	 
    FlipFlopD FF_VIDEO2 (.d(VidC), .clk(clkDiv), .rst_n(1'b1), .q(VidBlkC));
     
    // --- SENSOR D (LUZ) ---
	 
    wire Blkd0, Blkd1, VidD, VidBlkD, pixD;
    wire [15:0] rowD;
	 
    CriarBloco BLANKD_H (
	 .S(Blkd0), 
	 .A(Cordx), 
	 .ConstMin(10'd96), 
	 .ConstMax(10'd111));
	 
    CriarBloco BLANKD_V (
	 .S(Blkd1), 
	 .A(Cordy), 
	 .ConstMin(10'd0), 
	 .ConstMax(10'd15));
	 
    Sprite_Luz R_D (.address_y(Cordy[3:0]), .row_data(rowD));
	 
    assign pixD = rowD[4'd15 - Cordx[3:0]];
    and (VidD, Blkd0, Blkd1);
	 
    FlipFlopD FF_VIDEO3 (.d(VidD), .clk(clkDiv), .rst_n(1'b1), .q(VidBlkD));
    
    // =========================================================
    // --- 5. SAÍDA DE CORES ---
    // =========================================================
    wire [3:0]SR;
    wire final_red, Cb, Db;

	 
    // Lógica: Janela Ativa AND Sensor Ativo AND Pixel da ROM
    and (SR[0], VidBlkA, A, pixA);
    and (SR[1], VidBlkB, B, pixB);
    and (SR[2], VidBlkC, Cb, pixC);
    and (SR[3], VidBlkD, Db, pixD);

	 not(Cb, C);
	 not(Db, D);
	 
    or(final_red, SR[0], SR[1], SR[2], SR[3]); 
    
    assign R = {4{final_red}};
    assign G = 4'b0000;
    assign Blue = 4'b0000;
    
endmodule
