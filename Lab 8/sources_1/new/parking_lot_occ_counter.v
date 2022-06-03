`timescale 1ns / 1ps

module parking_lot_occ_counter(  
    input clk, resetP, sensA, sensB,
    output [6:0] sseg,
    output [0:7] AN,
    output DP
    );
    
    wire reset_n;
    //reset_n
    assign reset_n = ~resetP;

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
    
    
    reg [3:0] state_next, state_reg;
    localparam s0 = 0; //00
    localparam s1 = 1; //01 Initial
    localparam s2 = 2; //10 Initial
    localparam s3 = 3; //11 Enter
    localparam s4 = 4; //11 Out
    localparam s5 = 5; //01 Final
    localparam s6 = 6; //10 Final
    localparam s7 = 7;
    localparam s8 = 8;
    
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
        s0: if(sensAp & ~sensBp)
                state_next = s1;
            else if(~sensAp & sensBp)
                state_next = s2;       
        s1: if(sensAp & sensBp)
                state_next = s3;
            else if(~sensAp & ~sensBp)
                state_next = s0;      
        s2: if(sensAp & sensBp)
                state_next = s4;
            else if(~sensAp & ~sensBp)
                state_next = s0;       
        s3: if(sensAp & ~sensBp)
                state_next = s1;
            else if(~sensAp & sensBp)
                state_next = s5;              
        s4: if(sensAp & ~sensBp)
                state_next = s6;
            else if(~sensAp & sensBp)
                state_next = s2;   
        s5: if(sensAp & sensBp)
                state_next = s3;
            else if(~sensAp & ~sensBp)
                state_next = s7;
        s6: if(sensAp & sensBp)
                state_next = s4;
            else if(~sensAp & ~sensBp)
                state_next = s8;
        s7: state_next = s0;
        s8: state_next = s0;
        default: state_next = state_reg; 
        endcase
    end
    
    //Mealy Outputs
    wire car_enter, car_exit;
    assign car_enter = (state_reg == s7);
    assign car_exit = (state_reg == s8);
    
    
    //8-bit UP Counter
    wire [8 - 1:0] Q_out;
    udl_counter #(.BITS(8)) (
        .clk(clk),
        .reset_n(reset_n),
        .enable(car_enter | car_exit),
        .up(car_enter),
        .Q(Q_out)
    );
    
    //bin2bcd
    wire [11:0] bcd_out;
    bin2bcd(
        .bin(Q_out),
        .bcd(bcd_out)
    );
    
    //sseg_driver
    sseg_driver(
        .clk(clk),
        .reset(reset_n),
        .i7(6'b0xxxx0),
        .i6(6'b0xxxx0),
        .i5(6'b0xxxx0),
        .i4(6'b0xxxx0),
        .i3(6'b0xxxx0),
        .i2({1'b1, bcd_out[11:8], 1'b0}),
        .i1({1'b1, bcd_out[7:4], 1'b0}),
        .i0({1'b1, bcd_out[3:0], 1'b0}),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
    
endmodule
