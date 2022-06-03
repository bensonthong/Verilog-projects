`timescale 1ns / 1ps

module conseq_sequence(
    input clk, reset_n, x,
    output y
    );
    
    reg [2:0] state_next, state_reg;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    localparam s6 = 6;
    
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
        case(state_reg)
        s0: if(x)
                state_next = s1;
            else
                state_next = s4;
        s1: if(x)
                state_next = s2;
            else
                state_next = s4;
        s2: if(x)
                state_next = s3;
            else
                state_next = s4;
        s3: if(x) 
                state_next = s2;
            else
                state_next = s4;
        s4: if(x)
                state_next = s1;
            else
                state_next = s5;        
        s5: if(x)
                state_next = s1;
            else
                state_next = s6;
        s6: if(x)
                state_next = s1;
            else
                state_next = s5;
        default: state_next = state_reg; 
        endcase
    end
    
    // Output Logic
    assign y = (state_reg == s2 || state_reg == s3)&x || (state_reg == s5 || state_reg == s6)&~x ;  
endmodule
