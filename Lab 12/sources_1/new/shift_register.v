`timescale 1ns / 1ps

module shift_register
    #(parameter N = 5)(
        input clk, reset_n, SI, enable,
        output [N - 1:0] Q
    );
    
    reg [N - 1: 0] Q_reg, Q_next;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    //Next state logic
    always@(SI, Q_reg)
    begin
        //Left Shift
        Q_next = {Q_reg[N - 2: 0], SI};
    end
    
    assign Q = Q_reg;
endmodule