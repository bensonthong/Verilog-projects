`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2021 07:05:56 AM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
    input clk, reset_n, startpausecontinue,
    output DP,
    output [0:7] AN,
    output [6:0] sseg
    );
    
    wire reset_no;
    button R (
        .clk(clk),
        .in(reset_n),
        .out(reset_no)
    );
    
    wire startpausecontinueo;
    button start (
        .clk(clk),
        .in(startpausecontinue),
        .out(startpausecontinueo)
    );
    
    reg spu;
    always@(startpausecontinueo)
    begin
        case(startpausecontinueo)
            1'b0: spu = spu;
            1'b1: spu = ~spu;
            default : spu = 1'b0;
        endcase
    end
    wire done;
    timer_parameter #(.FINAL_VALUE(1000000)) T1 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(spu),
        .done(done)
    );
    wire done2;
    timer_parameter #(.FINAL_VALUE(100000000)) T2 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(spu),
        .done(done2)
    );
        wire done3;
    timer_parameter #(.FINAL_VALUE(100000000*60)) T3 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(spu),
        .done(done3)
    );
    
    wire [7:0] Q_out;
    // FF
    mod_counter_parameter #(.FINAL_VALUE(99))(
        .clk(clk),
        .reset_n(~reset_no),
        .enable(done),
        .Q(Q_out)
    );
    
    wire [11:0] bcd1;
    bin2bcd(
        .bin(Q_out),   //8-bit
        .bcd(bcd1)          //12-bit , interested in bcd[7:4] -> tenths digit , bcd[3:0], ones digit
    );
    wire [7:0] Q_out2;
//     SS
    mod_counter_parameter #(.FINAL_VALUE(59))(
        .clk(clk),
        .reset_n(~reset_no),
        .enable(done2),
        .Q(Q_out2)
    );
    wire [11:0] bcd2;
    bin2bcd(
        .bin(Q_out2),
        .bcd(bcd2)
    );
    wire [7:0] Q_out3;
//    //MM
    mod_counter_parameter #(.FINAL_VALUE(59))(
        .clk(clk),
        .reset_n(~reset_no),
        .enable(done3),
        .Q(Q_out3)
    );
    wire [11:0] bcd3;
    bin2bcd(
        .bin(Q_out3),
        .bcd(bcd3)
    );

    sseg_driver(
       .clk(clk),
       .reset_n(~reset_no),
       .i7(6'b0xxxx0),
       .i6(6'b0xxxx0),
       .i5({1'b1,bcd3[7:4],1'b0}),
       .i4({1'b1,bcd3[3:0],1'b1}),
       .i3({1'b1,bcd2[7:4],1'b0}),
       .i2({1'b1,bcd2[3:0],1'b1}),
       .i1({1'b1,bcd1[7:4],1'b0}),
       .i0({1'b1,bcd1[3:0],1'b0}),
       .sseg(sseg),
       .AN(AN),
       .DP(DP)

    
    );


endmodule