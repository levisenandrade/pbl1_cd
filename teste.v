module teste(F, L, P, T, S);
	input F, L, P, T;
	output [3:0] S;
	wire F0;
	
	// condiçao_F
	and (F0, T, P);
	and (S[0], F0, F);
	and (S[1], F0, L);
	and (S[2], F0, P);
	and (S[3], F0, T);

endmodule