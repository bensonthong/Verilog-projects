`timescale 1ns / 1ps

module stop_watch(
    input clk, resetP, enableP,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
     //buttons
    wire enable, reset;
    button E(
        .clk(clk),
        .in(enableP),
        .out(enable)
    );
    
    button R(
        .clk(clk),
        .in(resetP),
        .out(reset)
    );
    
    //pause unpuase
    reg pause_n;
    
    always @(enable)
    begin
        case(enable)
            1'b0 : pause_n = pause_n;
            1'b1 : pause_n = ~pause_n;
            default : pause_n = 1'b0;
        endcase
    end
    
    // 1 / 100th second clock cycle
    wire doneS;
    timer_parameter #(.FINAL_VALUE(10 ** 6)) (
        .clk(clk),
        .reset_n(~reset),
        .enable(pause_n),
        .done(doneS)
    );
    
    wire [3 : 0] FF0, FF1, SS0, SS1, MM0, MM1;
    wire done0, done1, done2, done3, done4, done5;
    wire a0, a1 ,a2, a3, a4, a5;
    // mod 10 counter (0 - 9) FF0
    mod_counter_parameter #(.FINAL_VALUE(9)) (
        .clk(doneS),
        .reset_n(~reset),
        .done(done0),
        .enable(1'b1),
        .Q(FF0)
    );
    assign a0 = 1'b1 & done0;
    // mod 10 counter (0 - 9) FF1
    mod_counter_parameter #(.FINAL_VALUE(9)) (
        .clk(doneS),
        .reset_n(~reset),
        .done(done1),
        .enable(a0),
        .Q(FF1)
    );
    assign a1 = a0 & done1;
    // mod 10 counter (0 - 9) SS0
    mod_counter_parameter #(.FINAL_VALUE(9)) (
        .clk(doneS),
        .reset_n(~reset),
        .done(done2),
        .enable(a1),
        .Q(SS0)
    );
    assign a2 = a1 & done2;
    // mod 6 counter (0 - 5) SS1
    mod_counter_parameter #(.FINAL_VALUE(5)) (
        .clk(doneS),
        .reset_n(~reset),
        .done(done3),
        .enable(a2),
        .Q(SS1)
    );
    assign a3 = a2 & done3;
    // mod 10 counter (0 - 9) MM0
    mod_counter_parameter #(.FINAL_VALUE(9)) (
        .clk(doneS),
        .reset_n(~reset),
        .done(done4),
        .enable(a3),
        .Q(MM0)
    );
    assign a4 = a3 & done4;
    // mod 6 counter (0 - 5) MM1
    mod_counter_parameter #(.FINAL_VALUE(5)) (
        .clk(doneS),
        .reset_n(~reset),
        .done(),
        .enable(a4),
        .Q(MM1)
    );

    
    sseg_driver(
        .clk(clk),
        .reset_n(~reset),
        .i7(6'b0xxxx0),
        .i6(6'b0xxxx0),
        .i5({1'b1, MM1, 1'b0}),
        .i4({1'b1, MM0, 1'b1}),
        .i3({1'b1, SS1, 1'b0}),
        .i2({1'b1, SS0, 1'b1}),
        .i1({1'b1, FF1, 1'b0}),
        .i0({1'b1, FF0, 1'b0}),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)   
    );
    
endmodule