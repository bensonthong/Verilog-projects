`timescale 1ns / 1ps

module bin2bcd(
    input [7:0] bin,
    output [11:0] bcd
    );
    
    assign bcd[0] = bin[0];
    
    wire [3:0] s0, s1, s2, s3, s4;
    
    add_3 A0(
        .a({0, bin[7], bin[6], bin[5]}),
        .s(s0)
    );
    add_3 A1(
        .a({s0[2], s0[1], s0[0], bin[4]}),
        .s(s1)
    );
    add_3 A2(
        .a({s1[2], s1[1], s1[0], bin[3]}),
        .s(s2)
    );
    add_3 A3(
        .a({s2[2], s2[1], s2[0], bin[2]}),
        .s(s3)
    );
    add_3 A4(
        .a({s3[2], s3[1], s3[0], bin[1]}),
        .s({bcd[4], bcd[3], bcd[2], bcd[1]})
    );
    ///////////////////////////////////////////
    add_3 A5(
        .a({0, s0[3], s1[3], s2[3]}),
        .s(s4)
    );
    add_3 A6(
        .a({s4[2], s4[1], s4[0], s3[3]}),
        .s({bcd[8], bcd[7], bcd[6], bcd[5]})
    );
    
    assign bcd[9] = s4[3];
    assign bcd[10] = 1'b0;
    assign bcd[11] = 1'b0;
    
endmodule