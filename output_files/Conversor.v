module Conversor(a, b, c, d, e, f, g, A, B, C, D);
	input A, B, C, D;
	output a, b, c, d, e, f, g;
	
	wire Ab, Bb, Cb, Db;
	
	not(Ab, A);
	not(Bb, B);
	not(Cb, C);
	not(Db, D);
	
	and and0(T[0], B, Cb);
	and and1(T[1], Bb, D);
	
	or(a, T[0], T[1]);
	
	and and2(T[2], C, D);
	and and3(T[3], D, Bb);
	
	or(b, T[2], T[3], A);
	
	or(c, T[2], T[3]);
	
	and(T[4], Cb, Db);
	or(T[5], Cb, Db);
	and(T[6], B, T[5]);
	
	or(d, T[6], T[4]);
	
	xor(T[7], B, C);
	and(e, Ab, Db, T[7]);
	
	and(f, B, Cb, Db);
	
	or(T[8], Bb, Db);
	and(T[9], Ab, Cb, T[8]);
	and(T[10], B, C, D);
	
	or(g, T[9], T[10]);
	