`timescale 1ns / 1ps

module mux_2x1_nbit
    #(parameter N = 8) (
    input [N - 1: 0] w0, w1,
    input s,
    output reg [N - 1: 0] f
    );
   
    // case (Multiplexing Networks)
    always @(w0, w1,s)
    begin
        case(s)
            1'b0: f = w0;
            1'b1: f = w1;
            default: f = 'bx;
        endcase
    end
endmodule