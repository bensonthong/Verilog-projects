`timescale 1ns / 1ps

module sseg_driver(
    input clk, reset_n,
    input [5:0] i7, i6, i5, i4, i3, i2, i1, i0,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    //timer
    wire done;
    timer_parameter #(.FINAL_VALUE(1000)) (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(done)
    );
    
    //counter 3bits
    wire [2:0] x;
    wire [2:0] x_out;
    udl_counter #(.BITS(3)) (
        .clk(clk),
        .reset_n(reset_n),
        .enable(done),
        .up(1'b1),
        .load(1'b0),
        .D(x),
        .Q(x_out)
    );
    
    //6-bit 8x1 Mux
    wire [5:0] D_out;
    mux_8x1_nbit(
        .w0(i0),
        .w1(i1),
        .w2(i2),
        .w3(i3),
        .w4(i4),
        .w5(i5),
        .w6(i6),
        .w7(i7),
        .s(x_out),
        .f(D_out)
        );
    
    wire [0:7] AN1;
    decoder_generic(
        .w(x_out),
        .en(D_out[5]),
        .y(AN1)
    );
    assign AN = ~AN1;
    
    hex2sseg(
        .hex(D_out[4:1]),
        .sseg(sseg)
    );
    
    assign DP = ~D_out[0];
    
endmodule