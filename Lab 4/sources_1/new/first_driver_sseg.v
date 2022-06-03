`timescale 1ns / 1ps

module first_sseg_driver(
    input [2:0] active_digit,
    input [3:0] num,
    input DP_ctrl,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    assign DP = DP_ctrl;
    
    wire [0:7] AN1;
    decoder_generic(
        .w(active_digit),
        .en(1'b1),
        .y(AN1)
    );
    
    assign AN = ~AN1;
    
    hex2sseg(
        .hex(num),
        .sseg(sseg)
    );
endmodule