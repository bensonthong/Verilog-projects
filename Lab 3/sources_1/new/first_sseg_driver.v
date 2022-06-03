`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2021 03:51:39 PM
// Design Name: 
// Module Name: first_sseg_driver
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


module first_sseg_driver(
    input [2:0] active_digit,
    input [3:0] num,
    input DP_ctrl,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    wire [0:7] AN1; 
 
    assign DP = DP_ctrl;
    
    decoder_generic DG1(
        .w(active_digit),
        .en(1'b1),
        .y(AN1)
    );
    assign AN = ~AN1; 
    
    hex2sseg H2SSEG1(
        .hex(num),
        .sseg(sseg)
    );
endmodule
