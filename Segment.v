`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Segment My_Seg(
//    .clk(),
//    .key(),
//    .seg(),
//    .an());
//////////////////////////////////////////////////////////////////////////////////


module Segment(
    input clk,
    input [15:0] key,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    
    reg [3:0]digit;
    reg [18:0]seg_count = 19'h00000;

    always_comb
    begin
        case (digit)
            4'b0001 : seg = 7'b1111001;
            4'b0010 : seg = 7'b0100100;
            4'b0011 : seg = 7'b0110000;
            4'b0100 : seg = 7'b0011001;
            4'b0101 : seg = 7'b0010010;
            4'b0110 : seg = 7'b0000010;
            4'b0111 : seg = 7'b1111000;
            4'b1000 : seg = 7'b0000000;
            4'b1001 : seg = 7'b0010000;
            4'b1010 : seg = 7'b0001000;
            4'b1011 : seg = 7'b0000011;
            4'b1100 : seg = 7'b1000110;
            4'b1101 : seg = 7'b0100001;
            4'b1110 : seg = 7'b0000110;
            4'b1111 : seg = 7'b0001110;
            default : seg = 7'b1000000;
        endcase
    end
    always @ (posedge clk)
    begin
        if (seg_count < 19'h 10000)
            begin
                digit = key % 10;
                an = 4'b1110;
            end
        else if
        (seg_count < 19'h 20000)
            begin
                digit = (key/10) % 10;
                an = 4'b1101;
            end
        else if
        (seg_count < 19'h 30000)
            begin
                digit = (key/100) % 10;
                an = 4'b1011;
            end
        else if
        (seg_count < 19'h 40000)
        begin
            digit = (key/1000) % 10;
            an = 4'b0111;
        end
        seg_count = seg_count +1;
    end
    
endmodule
