`timescale 1ns / 1ps

module sseg_driver(
    input clk, reset,
    input [2:0] D,
    input [5:0] i7, i6, i5, i4, i3, i2, i1, i0,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    //timer
    wire doneS;
    timer_parameter #(.FINAL_VALUE(255)) (
        .clk(clk),
        .reset_n(reset),
        .enable(1'b1),
        .done(doneS)
    );
    
    //3-bit UP Counter
    wire [2:0] Q_out;
    udl_counter #(.BITS(3)) (
        .clk(clk),
        .reset_n(reset),
        .enable(doneS),
        .up(1'b1),
        .load(1'b0),
        .D(),
        .Q(Q_out)
    );
    
    //6-bit 8x1 Mux
    reg [5:0] D_out;
    
    always @(Q_out)
    begin
        case(Q_out)
            7 : D_out = i7;
            6 : D_out = i6;
            5 : D_out = i5;
            4 : D_out = i4;
            3 : D_out = i3;
            2 : D_out = i2;
            1 : D_out = i1;
            0 : D_out = i0;
            default: D_out = 'b0;
        endcase
    end
    
    //3x8 Decoder
    wire [0:7] AN1;
    decoder_generic(
        .w(Q_out),
        .en(D_out[5]),
        .y(AN1)
    );
    
    assign AN = ~AN1;
    
    //HEX to 7 Segment Decoder
    hex2sseg(
        .hex(D_out[4:1]),
        .sseg(sseg)
    );
    
    //DP
    assign DP = ~D_out[0];
    
endmodule