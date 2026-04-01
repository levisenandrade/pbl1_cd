module ContadorVsync(
    input  wire clk,      // Clock de entrada (deve ser o pulso limpo do Hsync)
    output wire [9:0] q,  // Saída de 10 bits
    output wire rst_n     // Reset ativo em nível baixo
);

    // Fios das entradas D e dos sinais de "Enable" (Cascata)
    wire [9:0] d;
    wire e1, e2, e3, e4, e5, e6, e7, e8, e9;
    wire T;

    // --- Bit 0: Inverte a cada pulso de clock ---
    not gate_d0 (d[0], q[0]);
    FlipFlopD FFD0 (.d(d[0]), .clk(clk), .rst_n(rst_n), .q(q[0]));

    // --- Bit 1: Inverte se Q0 for 1 ---
    xor gate_d1 (d[1], q[1], q[0]);
    FlipFlopD FFD1 (.d(d[1]), .clk(clk), .rst_n(rst_n), .q(q[1]));

    // --- Bit 2: Inverte se Q0 e Q1 (E2) forem 1 ---
    and gate_e2 (e2, q[0], q[1]);
    xor gate_d2 (d[2], q[2], e2);
    FlipFlopD FFD2 (.d(d[2]), .clk(clk), .rst_n(rst_n), .q(q[2]));

    // --- Bit 3: Inverte se E2 e Q2 forem 1 ---
    and gate_e3 (e3, e2, q[2]);
    xor gate_d3 (d[3], q[3], e3);
    FlipFlopD FFD3 (.d(d[3]), .clk(clk), .rst_n(rst_n), .q(q[3]));

    // --- Bit 4 ---
    and gate_e4 (e4, e3, q[3]);
    xor gate_d4 (d[4], q[4], e4);
    FlipFlopD FFD4 (.d(d[4]), .clk(clk), .rst_n(rst_n), .q(q[4]));

    // --- Bit 5 ---
    and gate_e5 (e5, e4, q[4]);
    xor gate_d5 (d[5], q[5], e5);
    FlipFlopD FFD5 (.d(d[5]), .clk(clk), .rst_n(rst_n), .q(q[5]));

    // --- Bit 6 ---
    and gate_e6 (e6, e5, q[5]);
    xor gate_d6 (d[6], q[6], e6);
    FlipFlopD FFD6 (.d(d[6]), .clk(clk), .rst_n(rst_n), .q(q[6]));

    // --- Bit 7 ---
    and gate_e7 (e7, e6, q[6]);
    xor gate_d7 (d[7], q[7], e7);
    FlipFlopD FFD7 (.d(d[7]), .clk(clk), .rst_n(rst_n), .q(q[7]));

    // --- Bit 8 ---
    and gate_e8 (e8, e7, q[7]);
    xor gate_d8 (d[8], q[8], e8);
    FlipFlopD FFD8 (.d(d[8]), .clk(clk), .rst_n(rst_n), .q(q[8]));

    // --- Bit 9 ---
    and gate_e9 (e9, e8, q[8]);
    xor gate_d9 (d[9], q[9], e9);
    FlipFlopD FFD9 (.d(d[9]), .clk(clk), .rst_n(rst_n), .q(q[9]));

    // --- Lógica de Reset (Alvo Exato Modificado para 60Hz: 521) ---
    // Ativa T quando q = 10 0000 1001 binário
    // Ativa quando 512 (q9) + 8 (q3) + 1 (q0) = 521
    and gate_reset (T, q[9], q[3], q[0]);
    not gate_rst_n (rst_n, T);
	 
endmodule