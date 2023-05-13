`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//RO_Slice_En My_RO(
//    .INV_0 (),
//    .INV_1 (),
//    .INV_2 (),
//    .INV_3 (),
//    .SEL (),
//    .EN (),
//    .Bx (),
//    .MUX_OUT (),
//    .LATCH_OUT () );
//////////////////////////////////////////////////////////////////////////////////
(*DONT_TOUCH = "yes" *)

module RO_Slice_En(
    input INV_0,
    input INV_1,
    input INV_2,
    input INV_3,
    input SEL,
    input EN,
    input Bx,
    output MUX_OUT,
    output LATCH_OUT 
    );
    
    wire [3:0] INV_OUT;
    wire [4:0] LUT_MUX_OUT;
    
    assign INV_OUT[0] = ~INV_0;
    assign INV_OUT[1] = ~INV_1;
    assign INV_OUT[2] = ~INV_2;
    assign INV_OUT[3] = ~INV_3;
    
    mux_2t1_nb  #(.n(1)) mux_0  (
        .SEL   (~SEL), 
        .D0    (INV_OUT[0]), 
        .D1    (INV_OUT[1]), 
        .D_OUT (LUT_MUX_OUT[0]) );
          
    mux_2t1_nb  #(.n(1)) mux_1  (
        .SEL   (~SEL), 
        .D0    (INV_OUT[2]), 
        .D1    (INV_OUT[3]), 
        .D_OUT (LUT_MUX_OUT[1]) );
        
    mux_2t1_nb  #(.n(1)) mux_2  (
        .SEL   (~EN), 
        .D0    (LUT_MUX_OUT[0]), 
        .D1    (1'b0), 
        .D_OUT (LUT_MUX_OUT[2]) );
        
    mux_2t1_nb  #(.n(1)) mux_3  (
        .SEL   (~EN), 
        .D0    (LUT_MUX_OUT[1]), 
        .D1    (1'b0), 
        .D_OUT (LUT_MUX_OUT[3]) );
        
    mux_2t1_nb  #(.n(1)) mux_4  (
        .SEL   (Bx), 
        .D0    (LUT_MUX_OUT[2]), 
        .D1    (LUT_MUX_OUT[3]), 
        .D_OUT (MUX_OUT) );
    
    assign LUT_MUX_OUT[4] = MUX_OUT;
           
    Latch_ld_clr My_Latch(
        .D  (LUT_MUX_OUT[4]), 
        .ld (1'b1), 
        .clr(1'b0), 
        .Q  (LATCH_OUT) );    
endmodule