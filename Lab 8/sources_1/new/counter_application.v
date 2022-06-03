`timescale 1ns / 1ps

module counter_application(
    input clk, upP, downP, loadP, resetP,
    input [8 - 1: 0] load_input,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    //buttons
    wire up, down, load, reset;
    button U(
        .clk(clk),
        .in(upP),
        .out(up)
    );
    
    button D(
        .clk(clk),
        .in(downP),
        .out(down)
    );
    
    
    button L(
        .clk(clk),
        .in(loadP),
        .out(load)
    );
    
    
    button R(
        .clk(clk),
        .in(resetP),
        .out(reset)
    );
    
    //upDown
    reg upDown;
    
    always @(up, down)
    begin
        case({up, down})
            2'b00 : upDown = 1'bx;
            2'b01 : upDown = 1'b0;
            2'b10 : upDown = 1'b1;
            2'b11 : upDown = 1'bx;
        endcase
    end
    
    //8-bit UP Counter
    wire [8 - 1:0] Q_out;
    udl_counter #(.BITS(8)) (
        .clk(clk),
        .reset_n(~reset),
        .enable(up | down | load),
        .up(upDown),
        .load(load),
        .D(load_input),
        .Q(Q_out)
    );
    
    //bin2bcd
    wire [11:0] bcd_out;
    bin2bcd(
        .bin(Q_out),
        .bcd(bcd_out)
    );
    
    //sseg_driver
    sseg_driver(
        .clk(clk),
        .reset_n(~reset),
        .D(),
        .i7(6'b0xxxx0),
        .i6(6'b0xxxx0),
        .i5(6'b0xxxx0),
        .i4(6'b0xxxx0),
        .i3(6'b0xxxx0),
        .i2({1'b1, bcd_out[11:8], 1'b0}),
        .i1({1'b1, bcd_out[7:4], 1'b0}),
        .i0({1'b1, bcd_out[3:0], 1'b0}),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
    
endmodule