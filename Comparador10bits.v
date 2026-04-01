module Comparador10bits(Lt, Gt, Eq, A, B);
    input [9:0] A;      // Contador (h_count ou v_count)
    input [9:0] B;      // Constante da posição
    output Lt, Gt, Eq;

    // Fios para conectar a saída de um bit na entrada do próximo
    wire [9:0] lt_wire, gt_wire, eq_wire;

    // --- BIT 9 (MSB) ---
    // CORREÇÃO: As entradas de cascata iniciais DEVEM ser 0!
    Comparador1bit bit9(lt_wire[9], gt_wire[9], eq_wire[9], A[9], B[9], 1'b0, 1'b0);

    // --- BITS 8 a 1 ---
    Comparador1bit bit8(lt_wire[8], gt_wire[8], eq_wire[8], A[8], B[8], lt_wire[9], gt_wire[9]);
    Comparador1bit bit7(lt_wire[7], gt_wire[7], eq_wire[7], A[7], B[7], lt_wire[8], gt_wire[8]);
    Comparador1bit bit6(lt_wire[6], gt_wire[6], eq_wire[6], A[6], B[6], lt_wire[7], gt_wire[7]);
    Comparador1bit bit5(lt_wire[5], gt_wire[5], eq_wire[5], A[5], B[5], lt_wire[6], gt_wire[6]);
    Comparador1bit bit4(lt_wire[4], gt_wire[4], eq_wire[4], A[4], B[4], lt_wire[5], gt_wire[5]);
    Comparador1bit bit3(lt_wire[3], gt_wire[3], eq_wire[3], A[3], B[3], lt_wire[4], gt_wire[4]);
    Comparador1bit bit2(lt_wire[2], gt_wire[2], eq_wire[2], A[2], B[2], lt_wire[3], gt_wire[3]);
    Comparador1bit bit1(lt_wire[1], gt_wire[1], eq_wire[1], A[1], B[1], lt_wire[2], gt_wire[2]);

    // --- BIT 0 (LSB) ---
    Comparador1bit bit0(Lt, Gt, Eq, A[0], B[0], lt_wire[1], gt_wire[1]);

endmodule