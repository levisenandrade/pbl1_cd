module Logic(S, A, B, C, D);
	input A, B, C, D;
	output [3:0]S;
	
	wire Ab, Bb, Cb, Db;
	wire [9:0]T;
	
	not(Ab, A);
	not(Bb, B);
	not(Cb, C);
	not(Db, D);
	
	and(S[3], A, B, Cb);
	
	and(T[0], Ab, Cb, D);
	and(T[1], A, B, C);
	and(T[2], A, C, D);
	and(T[3], Bb, Cb, D);
	or(S[2], T[0], T[1], T[2], T[3]);
	
	and(T[4], Ab, B, Db);
	and(T[5], A, Bb);
	and(T[6], B, C);
	
	or(S[1], T[4], T[5], T[6]);
	
	and(T[7], Ab, B);
	and(T[8], Ab, C, D);
	and(T[9], A, Bb, D);
	
	or(S[0], T[7], T[8], T[9]);
	
endmodule