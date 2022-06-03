`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2021 05:01:43 PM
// Design Name: 
// Module Name: simple_calc
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


module simple_calc(
    input [3:0] x,y,
    input [1:0] op_sel,
    output [7:0]result,
    output carry_out,overflow
);

wire [3:0] r1; 

wire [7:0] r2;

adder_subtractor A0(
    .x(x),
    .y(y),
    .add_n(op_sel[0]),
    .s(r1),
    .c_out(carry_out),
    .overflow(overflow)
);

csa_multiplier CSA0(
    .m(x),
    .q(y),
    .p(r2)
);

mux_2x1_8bit M0(
    .x({4'b0,r1}),
    .y(r2),
    .s(op_sel[1]),
    .m(result)
);

endmodule
