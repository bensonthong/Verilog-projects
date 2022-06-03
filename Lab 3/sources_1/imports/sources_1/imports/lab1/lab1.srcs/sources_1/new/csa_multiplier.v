`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2021 03:32:22 PM
// Design Name: 
// Module Name: csa_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module csa_multiplier(
    input [3:0] m,q,
    output [7:0] p
);
    
    
    
    wire [3:0] r0;
    wire [3:0] r1;
    wire [3:0] r2;
    wire [3:0] r3;
    wire [10:0] c;
    wire [5:0] s;
    assign p[0] = r0[0];
    
    mq_4bit MQ0(
        .m(m),
        .q(q[0]),
        .mq(r0)
    );
    
    mq_4bit MQ1(
        .m(m),
        .q(q[1]),
        .mq(r1)
    );
    
     mq_4bit MQ2(
        .m(m),
        .q(q[2]),
        .mq(r2)
    );
    
     mq_4bit MQ3(
        .m(m),
        .q(q[3]),
        .mq(r3)
    );
    
    //row 1 FA1
    full_adder FA0(
        .x(r0[1]),
        .y(r1[0]),
        .c_in(0),
        .s(p[1]),
        .c_out(c[0])
    );
    
    //row 1 FA2
    full_adder FA1(
        .x(r0[2]),
        .y(r1[1]),
        .c_in(r2[0]),
        .s(s[0]),
        .c_out(c[1])
    );
    
    //row 1 FA3 
    full_adder FA2(
        .x(r0[3]),
        .y(r1[2]),
        .c_in(r2[1]),
        .s(s[1]),
        .c_out(c[2])
    );
    
    //row 1 FA4
    full_adder FA3(
        .x(0),
        .y(r1[3]),
        .c_in(r2[2]),
        .s(s[2]),
        .c_out(c[3])
    );
    
    //row 2 FA1 
    full_adder FA4(
        .x(s[0]),
        .y(0),
        .c_in(c[0]),
        .s(p[2]),
        .c_out(c[4])
    );
    
    //row2 FA2
     full_adder FA5(
        .x(s[1]),
        .y(r3[0]),
        .c_in(c[1]),
        .s(s[3]),
        .c_out(c[5])
     );
    
    //row2 FA3
     full_adder FA6(
        .x(s[2]),
        .y(r3[1]),
        .c_in(c[2]),
        .s(s[4]),
        .c_out(c[6])
     );
    
    //row2 FA4
     full_adder FA7(
        .x(r2[3]),
        .y(r3[2]),
        .c_in(c[3]),
        .s(s[5]),
        .c_out(c[7])
     );
    
    //row3 FA1
    full_adder FA8(
        .x(s[3]),
        .y(c[4]),
        .c_in(0),
        .s(p[3]),
        .c_out(c[8])
    );
    
    //row3 FA2
    full_adder FA9(
        .x(s[4]),
        .y(c[5]),
        .c_in(c[8]),
        .s(p[4]),
        .c_out(c[9])
    );
    //row3 FA3
     full_adder FA10(
        .x(s[5]),
        .y(c[6]),
        .c_in(c[9]),
        .s(p[5]),
        .c_out(c[10])
     );
    
    //row3 FA4
    full_adder FA11(
        .x(r3[3]),
        .y(c[7]),
        .c_in(c[10]),
        .s(p[6]),
        .c_out(p[7])
    );
    
endmodule
