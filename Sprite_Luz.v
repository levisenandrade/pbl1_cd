module Sprite_Luz(input [3:0] address_y, output reg [15:0] row_data);
    always @(*) begin
        case(address_y)
            4'h1: row_data = 16'h0100; 4'h2: row_data = 16'h1110;
            4'h3: row_data = 16'h0380; 4'h4: row_data = 16'h07C0;
            4'h5: row_data = 16'h47C4; 4'h6: row_data = 16'h0FE0;
            4'h7: row_data = 16'h0FE0; 4'h8: row_data = 16'h0FE0;
            4'h9: row_data = 16'h47C4; 4'hA: row_data = 16'h07C0;
            4'hB: row_data = 16'h0380; 4'hC: row_data = 16'h1110;
            4'hD: row_data = 16'h0100;
            default: row_data = 16'h0000;
        endcase
    end
endmodule