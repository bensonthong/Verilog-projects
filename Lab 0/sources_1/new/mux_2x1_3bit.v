`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 03:50:51 PM
// Design Name: 
// Module Name: mux_2x1_3bit
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


module mux_2x1_3bit(m,f,x,y,s);
    input [2:0] x, y ;
    input s;
    output [2:0] m;
    output f;
 
    
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
    assign s = f;
endmodule
