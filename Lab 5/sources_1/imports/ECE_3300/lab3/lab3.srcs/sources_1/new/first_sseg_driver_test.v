`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2021 05:26:40 PM
// Design Name: 
// Module Name: first_sseg_driver_test
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


module first_sseg_driver_test(
    input DP_ctrl,clk,reset_n,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    wire done;
    timer_parameter#(.FINAL_VALUE(1000))(
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(done)
    
    );
    
    wire [2:0] x;
    wire [2:0] xout;
    udl_counter #(.BITS(3))(
        .clk(clk),
        .reset_n(reset_n),
        .enable(done),
        .up(1'b1),
        .load(1'b0),
        .D(x),
        .Q(xout)
    );
    
    first_sseg_driver(
        .active_digit(xout),
        .num({1'b0,xout}),
        .DP_ctrl(DP_ctrl),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)
    );
    
endmodule
