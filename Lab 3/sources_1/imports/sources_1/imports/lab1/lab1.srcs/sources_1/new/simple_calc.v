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
    output [11:0] result,
    output c_out,overflow,
    output reg sign
);

wire [3:0] r1;  //results of adder/subtractor
wire [7:0] r2;  //results of multiplier
wire [3:0] r1a; //2's complement result 
wire[3:0] r1o;  //result of mux_2x1_4bit
wire [7:0] res; //results of mux_2x1_8bit

adder_subtractor A0(
    .x(x),
    .y(y),
    .add_n(op_sel[0]),
    .s(r1),
    .c_out(c_out),
    .overflow(overflow)
);

csa_multiplier CSA0(
    .m(x),
    .q(y),
    .p(r2)
);

//sign of adder/subtractor will depend on MSB which depends on the value of op_sel[1]
//if bit 0, sign will depend r1[3] which is the MSB of adder/subtractor else sign will be 0 which will not be a negative result(this is for unsigned multiplier)
 always @(op_sel[1])
    begin
        if(op_sel[1] == 1'b0)   
         sign = r1[3];
        else 
         sign = 1'b0;
    end  
    
//2's complement of r1
assign r1a = ~r1 + 1; 


mux_2x1_4bit mux4bit(
    .x(r1),
    .y(r1a),
    .s(sign),
    .m(r1o)
);

mux_2x1_8bit mux8bit(
    .x({4'b0,r1o}),
    .y(r2),
    .s(op_sel[1]),
    .m(res)
);

//converting mux_2x1_8bit result to bcd
bin2bcd B1(
    .bin(res),
    .bcd(result)
);

endmodule