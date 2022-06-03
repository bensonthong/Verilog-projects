`timescale 1ns / 1ps


module conseq_sequence_tb(

    );
    reg clk, reset_n, x;
    wire y;
    
    conseq_sequence uut(
        .clk(clk),
        .reset_n(reset_n),
        .x(x),
        .y(y)  
    );
    
    localparam T = 10;
    always
    begin
        clk = 1'b0;
        #(T/2); 
        clk =1'b1;
        #(T/2);
    end
    
    initial
    begin
        reset_n = 1'b0;
        x = 1'b0;
        @(negedge clk);
        reset_n = 1'b1;
        
        x= 1'b1;
    #T  x= 1'b1;
    #T  x= 1'b1;
    #T  x= 1'b0;
    #T  x= 1'b0;
    #T  x= 1'b0;
    #T  x= 1'b0;
    #T  x= 1'b0;
    #T  x= 1'b0;
    #T  x= 1'b0;
    #T  x= 1'b1; 
    #T  x= 1'b1; 
    #T  x= 1'b1; 
    #T  x= 1'b0; 
    #T  $finish;
    end
endmodule
