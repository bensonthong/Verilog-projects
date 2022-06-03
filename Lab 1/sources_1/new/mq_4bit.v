`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2021 03:04:09 PM
// Design Name: 
// Module Name: mq_4bit
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


module mq_4bit(
    input[3:0] m,
    input q,
    output [4:0] mq
    );
    assign mq[0] = m[0]&q;
    assign mq[1] = m[1]&q;
    assign mq[2] = m[2]&q;
    assign mq[3] = m[3]&q;
endmodule
