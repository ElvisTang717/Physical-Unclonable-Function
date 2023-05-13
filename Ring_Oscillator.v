`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Ring_Oscillator My_RO(
//    .SEL0(),
//    .SEL1(),
//    .SEL2(),
//    .Bx0(),
//    .Bx1(),
//    .Bx2(),
//    .EN(),
//    .RO_MUX_OUT(),
//    .RO_LATCH_OUT()
//    );
//////////////////////////////////////////////////////////////////////////////////


module Ring_Oscillator(
    input SEL0,
    input SEL1,
    input SEL2,
    input Bx0,
    input Bx1,
    input Bx2,
    input EN,
    output RO_MUX_OUT,
    output RO_LATCH_OUT
    );
    wire [2:0] MUX_OUT;
    wire [2:0] LATCH_OUT;
    
    RO_Slice_En RO_Slice_0(
        .INV_0 (MUX_OUT[2]),
        .INV_1 (LATCH_OUT[2]),
        .INV_2 (MUX_OUT[2]),
        .INV_3 (LATCH_OUT[2]),
        .SEL (SEL0),
        .EN (EN),
        .Bx (Bx0),
        .MUX_OUT (MUX_OUT[0]),
        .LATCH_OUT (LATCH_OUT[0]) );
        
    RO_Slice RO_Slice_1(
        .INV_0 (MUX_OUT[0]),
        .INV_1 (LATCH_OUT[0]),
        .INV_2 (MUX_OUT[0]),
        .INV_3 (LATCH_OUT[0]),
        .SEL (SEL1),
        .Bx (Bx1),
        .MUX_OUT (MUX_OUT[1]),
        .LATCH_OUT (LATCH_OUT[1]) );
        
    RO_Slice RO_Slice_2(
        .INV_0 (MUX_OUT[1]),
        .INV_1 (LATCH_OUT[1]),
        .INV_2 (MUX_OUT[1]),
        .INV_3 (LATCH_OUT[1]),
        .SEL (SEL2),
        .Bx (Bx2),
        .MUX_OUT (MUX_OUT[2]),
        .LATCH_OUT (LATCH_OUT[2]) );
        
    assign RO_MUX_OUT = MUX_OUT[2];
    assign RO_LATCH_OUT = LATCH_OUT[2];

endmodule
