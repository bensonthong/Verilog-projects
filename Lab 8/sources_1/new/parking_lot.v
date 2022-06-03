`timescale 1ns / 1ps

module parking_lot(  
    input clk, resetP, sensA, sensB,
    output [6:0] sseg,
    output [0:7] AN
    );
    
    //reset button
    wire reset, reset_n;
    button R(
        .clk(clk),
        .in(resetP),
        .out(reset)
    );
    
    //reset_n
    assign reset_n = ~reset;
    
    //debounce sensor buttons
    wire sensAp, sensBp;
    debouncer_delayed A(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(sensA),
        .debounced(sensAp)
    );
    debouncer_delayed B(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(sensB),
        .debounced(sensBp)
    );
    
    //concatinated sensor inputs for fsm logic
    reg [1:0] sensT;
    always @(*)
    begin
         sensT = {sensAp, sensBp};
    end
    
    
    reg [2:0] state_next, state_reg;
    localparam s0 = 0; //00
    localparam s1 = 1; //01 Initial
    localparam s2 = 2; //10 Initial
    localparam s3 = 3; //11 Enter
    localparam s4 = 4; //11 Out
    localparam s5 = 5; //01 Final
    localparam s6 = 6; //10 Final
    
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
        s0: if(sensT == 2'b10)
                state_next = s1;
            else if(sensT == 2'b01)
                state_next = s2;
            else
                state_next = state_reg;
        s1: if(sensT == 2'b11)
                state_next = s3;
            else if(sensT == 2'b00)
                state_next = s0;
            else
                state_next = state_reg;
                
        s2: if(sensT == 2'b11)
                state_next = s4;
            else if(sensT == 2'b00)
                state_next = s0;
            else
                state_next = state_reg;
                
        s3: if(sensT == 2'b01)
                state_next = s5;
            else if(sensT == 2'b10)
                state_next = s1;
            else
                state_next = state_reg;  
                
        s4: if(sensT == 2'b10)
                state_next = s6;
            else if(sensT == 2'b01)
                state_next = s2;
            else
                state_next = state_reg;
                                
        s5: if(sensT == 2'b11)
                state_next = s3;
            else if(sensT == 2'b00)
                state_next = s0;
            else
                state_next = state_reg;
                                
        s6: if(sensT == 2'b11)
                state_next = s4;
            else if(sensT == 2'b00)
                state_next = s0;
            else
                state_next = state_reg;
                
        default: state_next = state_reg; 
        endcase
    end
    
    //Mealy Outputs
    wire car_enter, car_exit;
    assign car_enter = (state_reg == s5)&(~sensA & ~sensB);
    assign car_exit = (state_reg == s6)&(~sensA & ~sensB);
    
    //Count up/down
    counter_application(
        .clk(clk), 
        .upP(car_enter), 
        .downP(car_exit), 
        .resetP(resetP),
        .sseg(sseg),
        .AN(AN),
        .DP()
    );
endmodule