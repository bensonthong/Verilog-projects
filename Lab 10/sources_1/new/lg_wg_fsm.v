`timescale 1ns / 1ps

module lg_wg_fsm(
    input clk, reset_n, b,
    output lg, wg
    );
    
    reg [2:0] state_next, state_reg;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    localparam s6 = 6;
    localparam s7 = 7;
    
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
        s0, s1, s2, s3, s4, s5, s6: 
            if(~b)
                state_next = state_reg + 1;
            else
                state_next = s0;
        s7: state_next = s0;
        default: state_next = state_reg;
        endcase
    end
    
    assign lg = (state_reg == s3);
    assign wg = (state_reg == s7);
endmodule