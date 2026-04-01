module Conversor(a, b, c, d, e, f, g, A, B, C, D, E);
    input A, B, C, D, E;
    output a, b, c, d, e, f, g;
    
    wire Ab, Bb, Cb, Db, Eb;
    wire [32:0]T;
    
    not(Ab, A);
    not(Bb, B);
    not(Cb, C);
    not(Db, D);
    not(Eb, E);
    
    // segmento a
    and(T[0], Ab, C, Db);
    and(T[1], T[7], Bb); // T[7] tem (Ab, Cb, E)
    and(T[2], T[29], E); // T[29] tem (Bb, Cb, Db)
    and(T[3], Bb, C, Db, Eb);
    and(T[4], T[9], Cb); // T[9] tem (B, D, E)
    and(T[5], B, C, Db, E);
    
    or(a, T[0], T[1], T[2], T[3], T[4], T[5]);
    
    // segmento b
    and(T[6], Ab, B);
    and(T[7], Ab, Cb, E);
    and(T[8], Ab, D, E);
    and(T[9], B, D, E);
    and(T[10], B, C, Eb);
    and(T[11], A, C, D, Eb);
    and(T[12], T[21], C, Db); // T[21] tem (A, Bb, E)
    
    or(b, T[6], T[7], T[8], T[9], T[10], T[11], T[12]);
    
    // segmento c
    and(T[13], T[6], Eb); // T[6] tem (Ab, B)
    and(T[14], B, C, D);
    and(T[15], T[26], Eb); // T[26] tem (A, Bb, Cb, D)
    
    or(c, T[8], T[13], T[10], T[14], T[1], T[15]);
    
    // segmento d
    // and(T[16], Ab, B); // Repetida, igual a T[6]
    and(T[16], Ab, Db, Eb);
    and(T[17], Ab, C, Eb);
    and(T[18], A, C, D, E);
    and(T[19], B, Cb, D, Eb);
    and(T[20], A, T[2]);

    or(d, T[6], T[16], T[0], T[17], T[3], T[18], T[19], T[20]);

    // segmento e
    and (T[21], A, Bb, E);
    // and (T[25], Bb, C, Db, Eb); // Repetida, igual a T[3]
    and (T[22], A, Cb, Db, E);
    and (T[23], Ab, Cb, D, Eb);
    
    or(e, T[21], T[3], T[22], T[23]);
    
    // segmento f
    and(T[24], T[6], E); // T[6] tem (Ab, B)
    and(T[25], T[21], Cb); // T[21] tem (A, Bb, E)
    and(T[26], A, Bb, Cb, D);
    and(T[27], T[21], D); // T[21] tem (A, Bb, E)
    and(T[28], T[0], Eb); // Já estava otimizada! (T[0] = Ab, C, Db)
    // and(T[33], B, C, Db, E); // Repetida, igual a T[5]

    or(f, T[24], T[25], T[26], T[27], T[28], T[5]);
    
    // segmento g
    and (T[29], Bb, Cb, Db);
    // and (T[35], Ab, B, E); // Repetida, igual a T[24]
    and (T[30], T[16], Bb); // T[17] tem (Ab, Db, Eb)
    and (T[31], Bb, C, D, E);
    and (T[32], T[10], Db); // T[10] tem (B, C, Eb)
    
    or(g, T[29], T[24], T[30], T[31], T[32]);
    
endmodule