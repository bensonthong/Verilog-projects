`timescale 1ns / 1ps

module vending_machine_fsm(
    input clk, reset_n, c5, c10, c25, item_taken,
    output dispense, r5, r10, r20, 
    output [5:0] state_value
    );
    
    reg [5:0] state_next, state_reg;
    localparam s0 = 0; 
    localparam s5 = 5;
    localparam s10 = 10;
    localparam s15 = 15;
    localparam s20 = 20;
    localparam s25 = 25;
    localparam s30 = 30;
    localparam s35 = 35;
    localparam s40 = 40;
    localparam s45 = 45;
    
    assign state_value = state_reg;
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
        s0: if(c5 & ~c10 & ~c25)
                state_next = s5;
            else if(~c5 & c10 & ~c25)
                state_next = s10;
            else if(~c5 & ~c10 & c25)
                state_next = s25;
        s5: if(c5 & ~c10 & ~c25)
                state_next = s10;
            else if(~c5 & c10 & ~c25)
                state_next = s15;
            else if(~c5 & ~c10 & c25)
                state_next = s30;
        s10:if(c5 & ~c10 & ~c25)
                state_next = s15;
            else if(~c5 & c10 & ~c25)
                state_next = s20;
            else if(~c5 & ~c10 & c25)
                state_next = s35;
        s15:if(c5 & ~c10 & ~c25)
                state_next = s20;
            else if(~c5 & c10 & ~c25)
                state_next = s25;
            else if(~c5 & ~c10 & c25)
                state_next = s40;
        s20:if(c5 & ~c10 & ~c25)
                state_next = s25;
            else if(~c5 & c10 & ~c25)
                state_next = s30;
            else if(~c5 & ~c10 & c25)
                state_next = s45;
        s25:if(item_taken)
                state_next = s0;
        s30:if(item_taken)
                state_next = s0;
        s35:if(item_taken)
                state_next = s0;
        s40:if(item_taken)
                state_next = s0;
        s45:if(item_taken)
                state_next = s0;
        default: state_next = state_reg;
        endcase
    end
    
    // Output Logic
    assign dispense =  (state_reg == s25) || (state_reg == s30) || (state_reg == s35) 
                                          || (state_reg == s40) || (state_reg == s45);
    assign r5 =  (state_reg == s30) || (state_reg == s40);
    assign r10 = (state_reg == s35) || (state_reg == s40);
    assign r20 = (state_reg == s45);
 endmodule