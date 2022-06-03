`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2021 09:12:41 PM
// Design Name: 
// Module Name: prior_encoder_test
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


module prior_encoder_test(
    input [15:0] w, 
    output [6:0] sseg,
    output z,DP,
    output [7:0] AN 
    );
    
    wire [3:0] y;
    wire z1;
    priority_encoder_generic #(.N(16)) PEG1(
        .w(w),
        .y(y),
        .z(z1)
    );
    
    hex2sseg H2SS1 (
        .hex(y),
        .sseg(sseg)
    );
    assign z = z1; 
    assign AN = 8'b11111110; 
    assign DP = 1'b1;
endmodule
