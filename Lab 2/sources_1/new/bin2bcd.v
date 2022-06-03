`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 03:01:29 AM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input [7:0] bin,
    output [11:0] bcd
    );
    assign bcd[0] = bin[0];
    wire [18:0] r;
    add_3 A1(
        .A({0,bin[7],bin[6],bin[5]}),
        .S({r[0],r[1],r[2],r[3]})
    );
    
    add_3 A2(
        .A({r[1],r[2],r[3],bin[4]}),
        .S({r[4],r[5],r[6],r[7]})
    );
    
    add_3 A3(
        .A({r[5],r[6],r[7],bin[3]}),
        .S({r[8],r[9],r[10],r[11]})
    );

    add_3 A4(
        .A({r[9],r[10],r[11],bin[2]}),
        .S({r[12],r[13],r[14],r[15]})
    );
    
    add_3 A5(
        .A({r[13],r[14],r[15],bin[1]}),
        .S({bcd[4],bcd[3],bcd[2],bcd[1]})
    );
    add_3 A6(
        .A({0,r[0],r[4],r[8]}),
        .S({bcd[9],r[16],r[17],r[18]})
    );
    add_3 A7(
        .A({r[16],r[17],r[18],r[12]}),
        .S({bcd[8],bcd[7],bcd[6],bcd[5]})
    );
    assign bcd[11] = 0;
    assign bcd[10] = 0;
endmodule
