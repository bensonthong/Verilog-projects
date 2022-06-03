`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2021 11:25:01 PM
// Design Name: 
// Module Name: mux_4x1_3bits
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


module mux_4x1_3bits(
    input [2:0] x,[2:0] y,[2:0] z,[2:0] w,
    input s0,s1,
    output [2:0] m,
    output f0,f1
  );
   wire [2:0] g0 ;
   wire [2:0] g1;
   
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
 
 assign s0=f0;
 assign s1=f1;
   endmodule 
  

