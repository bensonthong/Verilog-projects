`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 03:34:06 AM
// Design Name: 
// Module Name: bin2bcd_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simple_calc_bcd_tb(
);
 // 1) Declare local reg and wire identifiers
    
   reg [3:0] x;
   reg [3:0] y;
   reg [1:0] op_sel;
   wire [11:0] result;
   wire c_out,overflow,sign;
    // 2) Instantiate the module under test
    simple_calc uut (
        .x(x),
        .y(y),
        .op_sel(op_sel),
        .result(result),
        .c_out(c_out),
        .overflow(overflow),
        .sign(sign)
    );
    // 3) Specify a stopwatch to stop the simulation
    initial
    begin
        #60 $finish;
    end
    // 4) Generate stimuli, using initial and always
    initial
    begin
    
      x = 4'b1001;
      y=4'b0010; 
      op_sel= 2'b00;
      #10
      x=4'b1111;
      y=4'b0111;
      op_sel=2'b01;
      #10
      x=4'b0111;
      y=4'b1111;
      op_sel=2'b10;

    end
    // 5) Display the output response (text or graphics (or both) ) 
  
endmodule
