`timescale 1ns / 1ps



module even_odd_conseq00(
    input clk, reset_n, x,
    output y 
    );
    
    reg [2:0] state_reg, state_next;
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
        case(state_reg)
            s0: if(x)
                    state_next = s1; 
                else
                    state_next = s2;
              
            s1: if(x)
                    state_next = s0; 
                else
                    state_next = s5;
            
            s2: if(x)
                    state_next = s1; 
                else
                    state_next = s3;
            s3: if(x)
                    state_next = s4; 
                else
                    state_next = s3;
            s4: if(x)
                    state_next = s3; 
                else
                    state_next = s4;
            s5: if(x)
                    state_next = s0; 
                else
                    state_next = s4;
            default: state_next = state_reg;
        endcase
    end
    
    // Output Logic
    assign y = (state_reg == s4);
endmodule
