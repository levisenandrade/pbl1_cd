module Mux4inp(S, A, B, C, D, Slc0, Slc1);
	input A, B, C, D, Slc0, Slc1;
	output S;
	
	wire nSlc0, nSlc1;
	wire [7:0]T;
	
	not(nSlc0, Slc0);
	not(nSlc1, Slc1);
	
	and(T[0], nSlc0, nSlc1);
	and(T[1], nSlc0, Slc1);
	and(T[2], Slc0, nSlc1);
	and(T[3], Slc0, Slc1);
	
	and(T[4], T[0], A);
	and(T[5], T[1], B);
	and(T[6], T[2], C);
	and(T[7], T[3], D);
	
	or(S, T[4], T[5], T[6], T[7]);
endmodule