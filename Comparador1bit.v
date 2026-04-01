module Comparador1bit(Lt, Gt, Eq, A, B, Ltin, Gtin);
    input A, B, Ltin, Gtin;
    output Lt, Gt, Eq;
    wire Abar, Bbar, Ltinbar, Gtinbar, T0, T1;

    not Inv0(Abar, A);
    not Inv1(Bbar, B);
    not Inv2(Ltinbar, Ltin);
    not Inv3(Gtinbar, Gtin);
    and And0(T0, A, Bbar, Ltinbar);
    or Or0(Gt, T0, Gtin);
    and And1(T1, Abar, B, Gtinbar);
    or Or1(Lt, T1, Ltin);
    nor Nor0(Eq, Gt, Lt);
endmodule