`timescale 1ns / 1ps

module morse_decoder_application(
    input clk, reset_n, b,
    output [6:0] sseg,
    output [0:7] AN,
    output DP, lg, wg
    );
    
    // 100ms clk
    wire clk100;
    timer_parameter #(.FINAL_VALUE(9_999_999)) T0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(clk100)
    );
    
    wire dot, dash;
    morse_decoder(
        .clk(clk),
        .reset_n(reset_n),
        .b(b),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    
    //dot xor dash shifts left
    wire [4:0] Shift_out;
    shift_register(
        .clk(clk100),
        .reset_n(reset_n),
        .SI(dash),
        .enable(dot ^ dash),
        .Q(Shift_out)
    );
    
    wire [2:0] Counter_out;
    udl_counter #(.BITS(3)) (
        .clk(clk100),
        .reset_n(reset_n),
        .enable(dot ^ dash),
        .up(1'b1),
        .load(Counter_out == 5),
        .D(0),
        .Q(Counter_out)
    );
    
    reg [4:0] enable;
    always @(*)
    begin
        case(Counter_out)
            0: enable = 5'b00000;
            1: enable = 5'b00001;
            2: enable = 5'b00011;
            3: enable = 5'b00111;
            4: enable = 5'b01111;
            5: enable = 5'b11111;
        default: enable = 5'b00000;
        endcase
    end
    
    //sseg_driver
    sseg_driver(
        .clk(clk),
        .reset(reset_n),
        .i7({1'b1, 1'b0, Counter_out, 1'b0}),
        .i6(6'b0xxxx0),
        .i5(6'b0xxxx0),
        .i4({enable[4], 3'b0, Shift_out[4], 1'b0}),
        .i3({enable[3], 3'b0, Shift_out[3], 1'b0}),
        .i2({enable[2], 3'b0, Shift_out[2], 1'b0}),
        .i1({enable[1], 3'b0, Shift_out[1], 1'b0}),
        .i0({enable[0], 3'b0, Shift_out[0], 1'b0}),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
endmodule