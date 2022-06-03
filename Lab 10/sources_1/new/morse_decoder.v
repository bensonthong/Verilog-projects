`timescale 1ns / 1ps

module morse_decoder(
    input clk, reset_n, b,
    output dot, dash, lg, wg
    );
    
    //button b
    wire b_clean;
    button B(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(b),
        .debounced(b_clean)
    );
    
    // 100ms clk
    wire clk100;
    timer_parameter #(.FINAL_VALUE(9_999_999)) T0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(clk100)
    );
    
    //output dash & dot
    dot_dash_fsm(
        .clk(clk100),
        .reset_n(reset_n),
        .b(b_clean),
        .dot(dot),
        .dash(dash)
    );
    
    //lg = 1 if no dot or dash after 3 cycles
    //wg = 1 if no dot or dash after 7 cycles
    lg_wg_fsm(
        .clk(clk100),
        .reset_n(reset_n),
        .b(dot | dash), //or maybe .b(b_clean) ?
        .lg(lg),
        .wg(wg)
    );
    
endmodule