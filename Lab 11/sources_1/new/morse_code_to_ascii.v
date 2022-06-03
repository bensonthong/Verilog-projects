`timescale 1ns / 1ps


module morse_code_to_ascii(
    input b, re, clk, reset_n,
    output [6:0] sseg,
    output [0:7] AN, 
    output DP, empty
    );
    
    // b debounced
    wire b_debounced;
    button B(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(b),
        .debounced(b_debounced)
    );
    //re(read enable) debounced
    wire re_pedge;
    button RE(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(re),
        .p_edge(re_pedge)
    );
    

    wire dot, dash, lg, wg;
    morse_decoder_2 #(.TIMER_FINAL_VALUE(9_999_999)) Morse_Decoder(
        .clk(clk),
        .reset_n(reset_n),
        .b(b_debounced),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    
    // D flip flop 
    reg wg_delayed;
    always@(posedge clk)
    begin
        wg_delayed <= wg;     
    end
    
    //shift register
    wire [4:0] symbol;
    shift_register(
        .clk(clk),
        .reset_n(~(lg | wg)),
        .SI(dash),
        .enable(dot^dash),
        .Q(symbol)
    ); 
    
    // 3 bit counter 
    wire [2:0] symbolcount;
    udl_counter #(.BITS(3))(
        .clk(clk),
        .reset_n(~(lg | wg )),
        .enable(dot^dash),
        .up(1'b1),
        .load(symbolcount == 5),
        .D(0),
        .Q(symbolcount)
    );
   
    //mux for space
    reg [7:0] addr;
    always@(*)
    begin
        case(wg)
            0:  addr = {symbolcount, symbol};
            1:  addr = 8'b11100000; 
        endcase
    end
    
    // synch rom
    wire [7:0] data_out;
    synch_rom(
        .clk(clk),
        .addr(addr),
        .data(data_out)
    );
    
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    wire full;
    wire [7:0] dout;
    fifo_generator_0 FIFO (
      .clk(clk),      // input wire clk
      .srst(~reset_n),    // input wire srst
      .din(data_out),      // input wire [7 : 0] din
      .wr_en(~full & (lg | wg | wg_delayed) ),  // input wire wr_en
      .rd_en(re_pedge),  // input wire rd_en
      .dout(dout),    // output wire [7 : 0] dout
      .full(full),    // output wire full
      .empty(empty)  // output wire empty
    );
    

//    reg [4:0] enable;
//    always @(*)
//    begin
//        case(symbolcount)
//            0: enable = 5'b00000;
//            1: enable = 5'b00001;
//            2: enable = 5'b00011;
//            3: enable = 5'b00111;
//            4: enable = 5'b01111;
//            5: enable = 5'b11111;
//        default: enable = 5'b00000;
//        endcase
//    end
    
//    reg enable2;
//    always@(*)
//    begin
//        case(empty)
//        1'b0: enable2 = 1'b1;
//        1'b1: enable2 = 1'b0;
//        default: enable2 = 1'b0;
//        endcase
//    end
    
    //sseg_driver
    sseg_driver(
        .clk(clk),
        .reset(reset_n),
        .i7({~empty, dout[7:4], 1'b0}),
        .i6({~empty, dout[3:0], 1'b0}),
        .i5(6'b0xxxx0),
        .i4( {symbolcount >4, 3'b0, symbol[4], 1'b0} ),
        .i3( {symbolcount >3, 3'b0, symbol[3], 1'b0} ),
        .i2( {symbolcount > 2, 3'b0, symbol[2], 1'b0} ),
        .i1( {symbolcount >1, 3'b0, symbol[1], 1'b0} ),
        .i0( {symbolcount > 0, 3'b0, symbol[0], 1'b0} ),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)    
    );
endmodule
