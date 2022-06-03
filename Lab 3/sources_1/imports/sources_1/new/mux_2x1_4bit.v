`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2021 11:59:45 PM
// Design Name: 
// Module Name: mux_2x1_4bit
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


module mux_2x1_4bit(
    input [3:0] x, y, 
    input s,
    output [3:0] m
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
    
endmodule
