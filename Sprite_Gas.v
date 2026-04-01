module Sprite_Gas(input [3:0] address_y, output reg [15:0] row_data);
    always @(*) begin
        case(address_y)
            4'h3: row_data = 16'h01C0; 4'h4: row_data = 16'h03E0;
            4'h5: row_data = 16'h0EE0; 4'h6: row_data = 16'h1F70;
            4'h7: row_data = 16'h3FB8; 4'h8: row_data = 16'h3FF8;
            4'h9: row_data = 16'h1FF0; 4'hA: row_data = 16'h0FE0;
            4'hB: row_data = 16'h07C0; 
            default: row_data = 16'h0000;
        endcase
    end
endmodule