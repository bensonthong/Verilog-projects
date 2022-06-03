`timescale 1ns / 1ps

module dot_dash_fsm(
    input clk, reset_n, b,
    output dot, dash
    );
    
    reg [2:0] state_next, state_reg;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    
    // State Register
    always@(posedge clk, negedge reset_n)
    begin
        if(~reset_n)
                state_reg <= s0;
        else
                state_reg <= state_next;
    end
    
    // Next State Logic
    always@(*)
    begin
        state_next = state_reg;
        case(state_reg)
        s0: 
            if(b)
                state_next = s1;
            else
                state_next = s0;
        s1:
            if(b)
                state_next = s3;
            else
                state_next = s2;
        s3: 
            if(b)
                state_next = s4;
            else
                state_next = s0;
        s4:
            if(b)
                state_next = s4;
            else
                state_next = s5;
        s2, s5:
                state_next = s0;
        default: state_next = state_reg;
        endcase
    end
    
    assign dot = (state_reg == s2);
    assign dash = (state_reg == s5);
endmodule