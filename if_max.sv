`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//if_max max(
//    .clk(),
//    .cnt(),
//    .cnt_max());
//////////////////////////////////////////////////////////////////////////////////


module if_max(
    input clk,
    input [31:0] cnt,
    output logic cnt_max
    );
    
    always_ff @(posedge clk) begin
    if(cnt >= 60000000) 
        cnt_max = 1'b1;
    else
        cnt_max = 1'b0;
    end
    
endmodule
