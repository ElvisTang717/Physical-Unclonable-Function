`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Std_Counter Std_cnt_1(
//    .clk(),
//    .en(),
//    .clr(),
//    .clr_done(),
//    .cnt());
//////////////////////////////////////////////////////////////////////////////////

module Std_Counter(
    input clk,
    input en,
    input clr,
    output reg clr_done,
    output logic [31:0] cnt = 0
    );
    
    
    always_ff @(posedge clk)
    begin
        if (clr == 1'b1)
            cnt <= 0;
        else if(en == 1'b1) 
            cnt = cnt + 1;
        if(cnt == 0)begin
            clr_done = 1;
        end 
        else if(cnt != 0) begin
            clr_done = 0;
        end
        
    end
    
endmodule