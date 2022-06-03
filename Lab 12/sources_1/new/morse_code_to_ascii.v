`timescale 1ns / 1ps

module morse_to_ascii(
    input clk, reset_n, b_noisy,
    output [6:0] sseg,
    output [0:7] AN,
    output DP,tx
    );
    
    //button b
    wire b;
    button B(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(b_noisy),
        .debounced(b)
    );
    
    
    //Morse_Decoder
    wire dot, dash, lg, wg;
    morse_decoder_2 #(.TIMER_FINAL_VALUE(9_999_999)) Morse_Decoder(
        .clk(clk),
        .reset_n(reset_n),
        .b(b),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    
    //wg_delayed DFF
    reg wg_delayed;
    always@(posedge clk)
    begin
        wg_delayed <= wg;
    end
    
    //5-bit Shift Register Text
    wire [4:0] symbol;
    shift_register(
        .clk(clk),
        .reset_n( ~(lg | wg) & reset_n ),
        .SI(dash),
        .enable(dot ^ dash),
        .Q(symbol)
    );
    
    //3-bit UDL Counter
    wire [2:0] symbol_count;
    udl_counter #(.BITS(3)) (
        .clk(clk),
        .reset_n( ~(lg | wg) & reset_n ),
        .enable(dot ^ dash),
        .up(1'b1),
        .load(symbol_count == 5),
        .D(0),
        .Q(symbol_count)
    );
    
    //mux for space
    reg [7:0] addr;
    always@(*)
    begin
        case(wg)
            0:  addr = {symbol_count, symbol};
            1:  addr = 8'b11100000; //space
        endcase
    end
    
    //read data from address
    wire [7:0] data;
    synch_rom(
        .clk(clk),
        .addr(addr),
        .data(data)
    );
    
    uart(
        .clk(clk),
        .reset_n(reset_n),
        .r_data(),
        .rd_uart(0),
        .rx_empty(),
        .rx(),
        .w_data(data),
        .wr_uart(~full&(lg | wg | wg_delayed)),
        .tx_full(),
        .tx(tx),
        .TIMER_FINAL_VALUE(11'd650)
    );
    
    
    //sseg_driver
    sseg_driver(
        .clk(clk),
        .reset(reset_n),
        .i7(6'b0xxxx0),
        .i6(6'b0xxxx0),
        .i5(6'b0xxxx0),
        .i4( {symbol_count>4, 3'b0, symbol[4], 1'b0} ),
        .i3( {symbol_count>3, 3'b0, symbol[3], 1'b0} ),
        .i2( {symbol_count>2, 3'b0, symbol[2], 1'b0} ),
        .i1( {symbol_count>1, 3'b0, symbol[1], 1'b0} ),
        .i0( {symbol_count>0, 3'b0, symbol[0], 1'b0} ),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
    
    
endmodule