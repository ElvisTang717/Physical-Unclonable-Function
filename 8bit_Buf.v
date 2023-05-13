`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//Buf_8bit My_Buf(
//.D(),
//.ld(),
//.clr(),
//.Q()   );
//////////////////////////////////////////////////////////////////////////////////

module Buf_8bit (
    input clk,
    input wire [7:0] D,
    input wire ld,
    input wire clr,
    output reg [7:0] Q
    );
    
    always @(posedge clk)
    begin 
       if (ld == 1)
          Q <= D;
       else if (clr == 1)
          Q <= 0; 
    end
endmodule