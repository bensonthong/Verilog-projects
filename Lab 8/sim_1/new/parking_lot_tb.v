`timescale 1ns / 1ps


module parking_lot_tb(

    );
    reg clk, resetP, sensA,sensB;
    wire [6:0] sseg;
    wire [0:7] AN;
    
    parking_lot_occ_counter uut(
        .clk(clk),
        .resetP(resetP),
        .sensA(sensA),
        .sensB(sensB),
        .sseg(sseg),
        .AN(AN)  
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
        resetP = 1'b0;
        {sensA,sensB} = 1'b0;
        @(negedge clk);
        resetP = 1'b1;
        
    {sensA,sensB}= 2'b00;
    #T  {sensA,sensB}= 2'b10;
    #T  {sensA,sensB}= 2'b11;
    #T {sensA,sensB}= 2'b01;
    #T {sensA,sensB}= 2'b01;
    #T  {sensA,sensB}= 2'b11;
    #T  {sensA,sensB}= 2'b00;
    #T  {sensA,sensB}= 2'b01;
    #T  {sensA,sensB}= 2'b11;
    #T  {sensA,sensB}= 2'b10;
    #T {sensA,sensB}= 2'b00;
    #T  {sensA,sensB}= 2'b00;
    #T  {sensA,sensB}= 2'b00;
    #T  {sensA,sensB}= 2'b00; 
    #T  {sensA,sensB}= 2'b11;
    #T  {sensA,sensB}= 2'b11;
    #T {sensA,sensB}= 2'b01;
    #T {sensA,sensB}= 2'b01;
    #T  {sensA,sensB}= 2'b11;
    #T  {sensA,sensB}= 2'b00;
    #T  {sensA,sensB}= 2'b01;
    #T  {sensA,sensB}= 2'b11;
    #T  {sensA,sensB}= 2'b10;
    #T {sensA,sensB}= 2'b10;
    #T  {sensA,sensB}= 2'b01;
    #T  {sensA,sensB}= 2'b11;
    #T  {sensA,sensB}= 2'b00; 
    #T  $finish;
    end


endmodule
