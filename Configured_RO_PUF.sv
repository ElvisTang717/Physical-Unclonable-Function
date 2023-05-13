`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Configured_RO_PUF My_PUF(
//    .clk(),
//    .en(),
//    .chal(),
//    .btn(),
//    .key(),
//    .CATHODE(),
//    .ANODE());
//////////////////////////////////////////////////////////////////////////////////


module Configured_RO_PUF(
    input clk,
    input en,
    input [7:0] chal,
    input btn,
    input [3:0]hash_set,
    output en_check,
    output [7:0] key,
    output [6:0] seg,
    output [3:0] an,
    output logic hash_ready
    );
    
    wire [3:0] RO_out;
    wire MUX_Out;
    wire [31:0] RO_Cnt_Out; 
    wire RO_Cnt_Done;
    wire [31:0]Std_Cnt_Out; 
    wire Std_Clr_Done;
    wire Max_Check;
    wire Cnt_En;
    wire [7:0]Buf_Out;
    wire Clr_Flag;
    wire [127:0] hash_out ;
    wire [15:0] display_out ;
    
    assign en_check = en;
    
    // 4 PUFs
    Ring_Oscillator My_RO1(
    .SEL0(chal[0]),
    .SEL1(chal[1]),
    .SEL2(chal[2]),
    .Bx0(chal[3]),
    .Bx1(chal[4]),
    .Bx2(chal[5]),
    .EN(en),
    .RO_MUX_OUT(RO_out[0]),
    .RO_LATCH_OUT());
    
    Ring_Oscillator My_RO2(
    .SEL0(chal[0]),
    .SEL1(chal[1]),
    .SEL2(chal[2]),
    .Bx0(chal[3]),
    .Bx1(chal[4]),
    .Bx2(chal[5]),
    .EN(en),
    .RO_MUX_OUT(RO_out[1]),
    .RO_LATCH_OUT());
    
    Ring_Oscillator My_RO3(
    .SEL0(chal[0]),
    .SEL1(chal[1]),
    .SEL2(chal[2]),
    .Bx0(chal[3]),
    .Bx1(chal[4]),
    .Bx2(chal[5]),
    .EN(en),
    .RO_MUX_OUT(RO_out[2]),
    .RO_LATCH_OUT());
    
    Ring_Oscillator My_RO4(
    .SEL0(chal[0]),
    .SEL1(chal[1]),
    .SEL2(chal[2]),
    .Bx0(chal[3]),
    .Bx1(chal[4]),
    .Bx2(chal[5]),
    .EN(en),
    .RO_MUX_OUT(RO_out[3]),
    .RO_LATCH_OUT());
    
    // 4to1 MUX
    mux_4t1_nb  #(.n(1)) my_4t1_mux  (
    .SEL   (chal[7:6]), 
    .D0    (RO_out[0]), 
    .D1    (RO_out[1]), 
    .D2    (RO_out[2]), 
    .D3    (RO_out[3]),
    .D_OUT (MUX_Out) );  

    // RO Counter
    RO_counter RO_cnt_1(
    .mux_in(MUX_Out),
    .en(Cnt_En),
    .clr(Clr_Flag),
    .done(RO_Cnt_Done),
    .cnt(RO_Cnt_Out[31:0]));
    
    // 8 bits Buffer
    Buf_8bit My_Buf(
    .clk(clk),
    .D(RO_Cnt_Out[24:17]),
    .ld(RO_Cnt_Done),
    .clr(Clr_Flag),
    .Q(Buf_Out[7:0])   );
    
    assign key = Buf_Out[7:0];
    
    // Std Counter
    Std_Counter Std_cnt_1(
    .clk(clk),
    .en(Cnt_En),
    .clr(Clr_Flag),
    .clr_done(Std_Clr_Done),
    .cnt(Std_Cnt_Out));
    
    //if max
    if_max max(
    .clk(clk),
    .cnt(Std_Cnt_Out),
    .cnt_max(Max_Check));
    
    // Counter Enable Control
    assign Cnt_En = (~Max_Check) & en;
    
    // Flag Control 
    Flag_Control clrFlag(
    .clk(clk),
    .chal(chal [7:0]),
    .btn(btn),
    .clr_done(Std_Clr_Done),
    .clr(Clr_Flag));   
    
    // SHA 128
    sha128_simple SHA( 
    .CLK(clk),
    .DATA_IN({challenge,Buf_Out[7:0]}),
    .RESET(btn),
    .START(btn),
    .READY(hash_ready),
    .DATA_OUT(hash_out));
    
    // Display select between std_contr and SHA 128
    display_control display(
    .clk(clk),
    .control(hash_set),
    .normal(Buf_Out[7:0]),
    .hash_out(hash_out),
    .display_out(display_out));
    
    // Seven Segment Display
    Segment My_Seg(
    .clk(clk),
    .key(display_out),
    .seg(seg),
    .an(an));

endmodule
