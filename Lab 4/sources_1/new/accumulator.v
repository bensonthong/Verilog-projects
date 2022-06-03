`timescale 1ns / 1ps



module accumulator(
    input [3:0] x,
    input clk,load,reset_n,add_n,
    output [6:0] sseg,
    output [0:7] AN
    );
    
    wire [3:0] sum,s;
    wire push,reset;
   

    button L(
        .clk(clk),
        .in(load),
        .out(push)
    );
        
    button R(
        .clk(clk),
        .in(reset_n),
        .out(reset)
    );

   
    adder_subtractor (
        .x(x),
        .y(s),
        .add_n(add_n),
        .s(sum)
    );
    
    simple_register_load#(.N(4))(
        .clk(clk),
        .load(push),
        .I(sum),
        .Q(s),
        .reset_n(reset)    
    );
   
    hex2sseg(
        .hex(s),
        .sseg(sseg)
    );
 
 assign AN = 8'b01111111;

endmodule
