`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//RO_counter RO_cnt_1(
//    .mux_in(),
//    .en(),
//    .clr(),
//    .done()
//    .cnt());
//////////////////////////////////////////////////////////////////////////////////


module RO_counter(
    input mux_in,
    input en,
    input clr,
    output reg done,
    output logic [31:0] cnt = 0       // Will count overflow automatically?
    );
    
    always_ff @(posedge mux_in)
    begin
        if (clr == 1'b1) 
        begin
            cnt = 0;   
        end
        
        else if(en == 1'b1)
        begin
            cnt += 1;
            done = 0;
        end
        else if(en == 1'b0)
        begin
            done = 1;
        end
    end
    
    
endmodule
