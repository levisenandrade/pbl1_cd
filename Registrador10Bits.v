module Registrador10Bits(
    input  wire [9:0] d_in,   // Entrada paralela de 10 bits
    input  wire       clk,    // Clock do sistema
    input  wire       rst_n,  // Reset geral
    output wire [9:0] q_out   // Saída paralela de 10 bits
);

    // Instanciando 10 Flip-Flops D em paralelo
    FlipFlopD ff0 (.d(d_in[0]), .clk(clk), .rst_n(rst_n), .q(q_out[0]));
    FlipFlopD ff1 (.d(d_in[1]), .clk(clk), .rst_n(rst_n), .q(q_out[1]));
    FlipFlopD ff2 (.d(d_in[2]), .clk(clk), .rst_n(rst_n), .q(q_out[2]));
    FlipFlopD ff3 (.d(d_in[3]), .clk(clk), .rst_n(rst_n), .q(q_out[3]));
    FlipFlopD ff4 (.d(d_in[4]), .clk(clk), .rst_n(rst_n), .q(q_out[4]));
    FlipFlopD ff5 (.d(d_in[5]), .clk(clk), .rst_n(rst_n), .q(q_out[5]));
    FlipFlopD ff6 (.d(d_in[6]), .clk(clk), .rst_n(rst_n), .q(q_out[6]));
    FlipFlopD ff7 (.d(d_in[7]), .clk(clk), .rst_n(rst_n), .q(q_out[7]));
    FlipFlopD ff8 (.d(d_in[8]), .clk(clk), .rst_n(rst_n), .q(q_out[8]));
    FlipFlopD ff9 (.d(d_in[9]), .clk(clk), .rst_n(rst_n), .q(q_out[9]));

endmodule