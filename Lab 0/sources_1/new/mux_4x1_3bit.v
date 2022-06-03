`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2021 10:57:01 PM
// Design Name: 
// Module Name: mux_4x1_3bit
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


module mux_4x1_3bit(
    input  x,y,z,w,
    input s0,s1,
    output  m
  
    );
   wire g0,g1;
   
  mux_2x1_3bit M0(
 .x(x),
 .y(y),
 .s(s0),
 .m(g0)
 );
 
 mux_2x1_3bit M1(
 .x(z),
 .y(w),
 .s(s0),
 .m(g1)
 );
 
  mux_2x1_3bit M2(
 .x(g0),
 .y(g1),
 .s(s1),
 .m(m)
 );
        
  
