module udl_counter
    #(parameter BITS = 3)(
    input clk,
    input reset_n,
    input enable,
    input up, //when asserted the counter is up counter; otherwise, it is a down counter
    input down,
    input load,
    input [BITS - 1:0] D,
    output [BITS - 1:0] Q
    );
    
    reg [BITS - 1:0] Q_reg, Q_next;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    // Next state logic
    
      always @(Q_reg, up, down, load, D)
    begin
        Q_next = Q_reg;
        casex({load,down,up})
            3'b000: Q_next = Q_reg + 1;
            3'b001: Q_next = Q_reg + 1;
            3'b01x: Q_next = Q_reg - 1;
            3'b1xx: Q_next = D;
            default: Q_next = Q_reg;
        endcase
        
    end 
    
    // Output logic
    assign Q = Q_reg;
endmodule