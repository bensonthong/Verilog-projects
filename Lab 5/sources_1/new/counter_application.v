`timescale 1ns / 1ps

module counter_application(
    input [7:0] load_input,
    input up,down,reset_n, load, clk,
    output [0:7] AN,
    output [6:0] sseg,
    output DP
);

    wire upo,downo,reset_no;
    //reset button
    button Reset(
        .clk(clk),
        .in(reset_n),
        .out(reset_no)
    );
    //up button
    button Up(
        .clk(clk),
        .in(up),
        .out(upo)
    );
    //down button
    button Down(
        .clk(clk),
        .in(down),
        .out(downo)
    );
    
   //8-bit counter
    wire [7:0] Q_out;
    udl_counter #(.BITS(8))(
        .clk(clk),
        .reset_n(~reset_no),
        .enable(upo | downo| load),
        .up(upo),
        .down(downo),
        .load(load),
        .D(load_input),
        .Q(Q_out)
    );
    
    //counter output to bcd
    wire [11:0] bcd;
    bin2bcd(
        .bin(Q_out),
        .bcd(bcd)
    );
    
    //sseg driver 
    sseg_driver(
        .clk(clk),
        .reset_n(~reset_no),
        .i7(6'b0xxxx0),
        .i6(6'b0xxxx0),
        .i5(6'b0xxxx0),
        .i4(6'b0xxxx0),
        .i3(6'b0xxxx0),
        .i2({1'b1, bcd[11:8], 1'b0}),
        .i1({1'b1, bcd[7:4], 1'b0}),
        .i0({1'b1, bcd[3:0], 1'b0}),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
endmodule
