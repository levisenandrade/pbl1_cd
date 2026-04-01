module Sprite_Temp(input [3:0] address_y, output reg [15:0] row_data);
    always @(*) begin
        case(address_y)
            4'h2: row_data = 16'h0180; 4'h3: row_data = 16'h0180;
            4'h4: row_data = 16'h0180; 4'h5: row_data = 16'h0180;
            4'h6: row_data = 16'h0180; 4'h7: row_data = 16'h0180;
            4'h8: row_data = 16'h0180; 4'h9: row_data = 16'h03C0;
            4'hA: row_data = 16'h07E0; 4'hB: row_data = 16'h0FF0;
            4'hC: row_data = 16'h0FF0; 4'hD: row_data = 16'h07E0;
            4'hE: row_data = 16'h03C0; 
            default: row_data = 16'h0000;
        endcase
    end
endmodule