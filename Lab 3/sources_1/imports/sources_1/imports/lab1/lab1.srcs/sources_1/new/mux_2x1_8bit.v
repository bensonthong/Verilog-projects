module mux_2x1_8bit(
    input [7:0] x, y,
    input  s,
    output [7:0] m
);
    
    mux_2x1_simple M0(
        .x1(x[0]),
        .x2(y[0]),
        .s(s),
        .f(m[0])
    );
        
    mux_2x1_simple M1(
        .x1(x[1]),
        .x2(y[1]),
        .s(s),
        .f(m[1])
    );
    mux_2x1_simple M2(
        .x1(x[2]),
        .x2(y[2]),
        .s(s),
        .f(m[2])
    );
     mux_2x1_simple M3(
        .x1(x[3]),
        .x2(y[3]),
        .s(s),
        .f(m[3])
    );
     mux_2x1_simple M4(
        .x1(x[4]),
        .x2(y[4]),
        .s(s),
        .f(m[4])
    );
     mux_2x1_simple M5(
        .x1(x[5]),
        .x2(y[5]),
        .s(s),
        .f(m[5])
    );
     mux_2x1_simple M6(
        .x1(x[6]),
        .x2(y[6]),
        .s(s),
        .f(m[6])
    );
     mux_2x1_simple M7(
        .x1(x[7]),
        .x2(y[7]),
        .s(s),
        .f(m[7])
    );
 
     
endmodule