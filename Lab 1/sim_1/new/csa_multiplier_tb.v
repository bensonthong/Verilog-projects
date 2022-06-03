`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2021 04:25:48 PM
// Design Name: 
// Module Name: csa_multiplier_tb
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


module csa_multiplier_tb(

    );
    
    // 1) Declare local reg and wire identifiers
    reg [3:0] m, q;
    wire[7:0] p;
    // 2) Instantiate the module under test
    csa_multiplier uut (
        .m(m),
        .q(q),
        .p(p)
    );
    // 3) Specify a stopwatch to stop the simulation
    initial
    begin
        #60 $finish;
    end
    // 4) Generate stimuli, using initial and always
    initial
    begin
    //14*11
       m= 4'b1110;
       q=4'b1011;
       
       #10
    //0*10   
       m=4'b0000;
       q=4'b1010;
       #10
    //5*5
       m=4'b0101;
       q=4'b0101;
       #10
    //9*5
       m=4'b1001;
       q=4'b0101;
       #10
    //12*13
       m=4'b1100;
       q=4'b1101;   
       #10
    //15*10
       m=4'b1111;
       q=4'b1010;

    end
    // 5) Display the output response (text or graphics (or both) ) 
endmodule
