`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//      //- Usage example for instantiating 16-bit register
//      Latch_ld_clr (
//          .data_in  (xxxx), 
//          .ld       (xxxx), 
//          .clr      (xxxx), 
//          .data_out (xxxx)    );  
//////////////////////////////////////////////////////////////////////////////////

module Latch_ld_clr (
    input wire D,
    input wire ld,
    input wire clr,
    output reg Q
    );
    
    always @(D)
    begin 
       if (ld == 1)
          Q <= D;
       else if (clr == 1)
          Q <= 0; 
    end
endmodule