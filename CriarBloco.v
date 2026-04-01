module CriarBloco(S, A, ConstMin, ConstMax);
	input [9:0]A;
	input [9:0]ConstMin;
	input [9:0]ConstMax;
	
	output S;
	
	wire T0, T1, Gt, Lt, Cond1, Eq;
	
	Comparador10bits Comp0(
	.Lt(),
	.Gt(Gt),
	.Eq(T0),
	.A(A),
	.B(ConstMin));

	Comparador10bits Comp1(
	.Lt(Lt),
	.Gt(),
	.Eq(T1),
	.A(A),
	.B(ConstMax));
	
	or(Eq, T0, T1);
	and(Cond1, Lt, Gt);
	or(S, Cond1, Eq);
	
endmodule