`timescale 1ns / 1ps

module add_3(
    input [3:0] a,
    output reg [3:0] s
    );
    
    always @(*)
    begin
        if(a < 10)
            begin
                if(a > 4) s = a + 3;
                else s = a;
            end
        else
            s = 4'bxxxx;
    end
endmodule