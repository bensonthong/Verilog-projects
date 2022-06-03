`timescale 1ns / 1ps


module vending_machine(
    input clk, reset_n, c5_n, c10_n, c25_n, item_taken_n,
    output r5, r10, r20,
    output [6:0] sseg,
    output [0:7] AN,
    output DP, 
    output red_LED, green_LED, blue_LED
    );
    
    //buttons
    wire c5, c10, c25, item_taken;
    button NICKEL(.clk(clk), .reset_n(reset_n), .noisy(c5_n), .p_edge(c5));
    button DIME(.clk(clk), .reset_n(reset_n), .noisy(c10_n), .p_edge(c10));
    button QUARTER(.clk(clk), .reset_n(reset_n), .noisy(c25_n), .p_edge(c25));
    button TAKE(.clk(clk), .reset_n(reset_n), .noisy(item_taken_n), .p_edge(item_taken));
    
    wire [5:0] money_bin;
    reg [5:0] change_bin;
    wire dispense;
    vending_machine_fsm F(
        .clk(clk),
        .reset_n(reset_n),
        .c5(c5),
        .c10(c10),
        .c25(c25),
        .item_taken(item_taken),
        .dispense(dispense),
        .r5(r5),
        .r10(r10),
        .r20(r20),
        .state_value(money_bin)
    );
    
    always@(*)
    begin
        if(dispense)
            change_bin = money_bin - 25;
        else
            change_bin = 0;
    end
    
rgb_driver (
        .clk(clk),
        .reset_n(reset_n),
        .red_duty({~dispense, 8'b00000000}),
        .green_duty({dispense, 8'b00000000}),
        .blue_duty('b0),
        .red_LED(red_LED),
        .green_LED(green_LED),
        .blue_LED(blue_LED)
    );
    //bin2bcd
    wire [11:0] money_out, change_out;
    bin2bcd MONEY(
        .bin(money_bin),
        .bcd(money_out)
    );
    
    bin2bcd CHANGE(
        .bin(change_bin),
        .bcd(change_out)
    );
    
    //sseg_driver
    sseg_driver(
        .clk(clk),
        .reset(reset_n),
        .D(),
        .i7(6'b0xxxx0),
        .i6( {1'b1, change_out[11:8], 1'b1} ),
        .i5( {1'b1, change_out[7:4], 1'b0} ),
        .i4( {1'b1, change_out[3:0], 1'b0} ),
        .i3(6'b0xxxx0),
        .i2( {1'b1, money_out[11:8], 1'b1} ),
        .i1( {1'b1, money_out[7:4], 1'b0} ),
        .i0( {1'b1, money_out[3:0], 1'b0} ),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
    
endmodule