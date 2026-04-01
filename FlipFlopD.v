module FlipFlopD (
    input  wire d,      // Entrada de dados
    input  wire clk,    // Sinal de clock
    input  wire rst_n,  // Reset ativo em nível baixo (active low)
    output reg  q       // Saída q
);

    // O bloco 'always' é disparado na borda de subida do clock 
    // ou na borda de descida do reset (transição para o estado ativo)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Se o reset for acionado, a saída vai para zero
            q <= 1'b0;
        end else begin
            // Caso contrário, na borda do clock, q recebe o valor de d
            q <= d;
        end
    end

endmodule