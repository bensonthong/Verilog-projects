`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2021 05:38:53 PM
// Design Name: 
// Module Name: simple_calc_first_sseg
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


module simple_calc_first_sseg(
    input [3:0] x,y,
    input [1:0] op_sel,
    input [1:0]dig_sel,
    output cout, overflow, sign, DP,
    output [6:0] sseg,
    output [0:7] AN
  
    );
    wire [2:0] dig_sel4;
    wire [11:0] res;
    wire [3:0] dig;
    assign dig_sel4 = dig_sel+4;
    
    simple_calc SC1(
    .x(x),
    .y(y),
    .op_sel(op_sel),
    .result(res),
    .c_out(cout),
    .overflow(overflow),
    .sign(sign)
    );
    
    mux_4x1_nbit (
        .w0(res[3:0]),
        .w1(res[7:4]), 
        .w2(res[11:8]), 
        .w3(4'b0000),
        .s(dig_sel),
        .f(dig)
    );
    first_sseg_driver FSSD1( 
        .active_digit(dig_sel4),
        .num(dig),
        .DP_ctrl(1'b1),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)
    );
endmodule
