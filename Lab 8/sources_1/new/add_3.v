`timescale 1ns / 1ps

module add_3(
    input [3:0] a,
    output reg [3:0] s
    );
    always @(a)
    begin
        s=4'bxxxx;
        case(a)
            4'b0000: s=4'b0000;
            4'b0001: s=4'b0001;
            4'b0010: s=4'b0010;
            4'b0011: s=4'b0011;
            4'b0100: s=4'b0100;
            4'b0101: s=4'b1000;
            4'b0110: s=4'b1001;
            4'b0111: s=4'b1010;
            4'b1000: s=4'b1011;
            4'b1001: s=4'b1100;
            default: s=4'bxxxx;
        endcase
    end
    
endmodule