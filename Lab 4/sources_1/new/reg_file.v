`timescale 1ns / 1ps



module reg_file 
    #(parameter N=3, BITS = 4)(
    input clk,WE,
    input [BITS-1:0] data_w,
    output [BITS-1:0] data_r
  );
  
  wire [0: 2**N-1] address_wo;
  wire [BITS - 1:0] data_wo[0:2**N-1]; 
    wire [BITS - 1:0] addres_ro[0:2**N-1]; 
   decoder_generic#(.N(N)) aw(
        .w(address_w),
        .en(WE),
        .y(address_wo)
   );

   decoder_generic#(.N(N)) ar(
        .w(address_r),
        .en(WE),
        .y(address_ro)
   );
 

 
   genvar k;
   generate
    for(k=0; k<2**N; k=k+1)
    begin: Register
    simple_register_load#(.N(BITS))(
        .clk(clk),
        .load(address_wo[k]),
        .I(data_w),
        .Q(data_wo[k])    
    );
    end
   endgenerate       
   

genvar p;
generate
    for(p=0; p<2**N;p=p +1)
    begin
        assign data_r = (address_ro[p]) ? data_wo[p]: 1'bz;
    
    end
endgenerate



  

endmodule
