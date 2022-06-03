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


module bin2bcd_tb(
);
 // 1) Declare local reg and wire identifiers
    reg [7:0] bin;
    wire[11:0] bcd;
    // 2) Instantiate the module under test
    bin2bcd uut (
        .bin(bin),
        .bcd(bcd)
    );
    // 3) Specify a stopwatch to stop the simulation
    initial
    begin
        #60 $finish;
    end
    // 4) Generate stimuli, using initial and always
    initial
    begin
    
       bin = 4'b0001;
       #10
        bin = 4'b1111;
       #10
        bin=4'b1110;
       #10
       bin=8'b11111111;
       #10
       bin=8'b11110111;

    end
    // 5) Display the output response (text or graphics (or both) ) 
  
endmodule
