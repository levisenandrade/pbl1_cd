module DivFreq(S, Clk);
	input Clk;
	output S;
	
	wire Sn;
	not(Sn, S);
	
	FlipFlopD FFD0(
	.d(Sn),
	.clk(Clk),
	.rst_n(1),
	.q(S));
	
endmodule