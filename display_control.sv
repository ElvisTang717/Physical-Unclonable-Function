`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//display_control display(
//    .clk(),
//    .control(),
//    .normal(),
//    .hash_out(),
//    .display_out());
//////////////////////////////////////////////////////////////////////////////////


module display_control(
    input clk,
    input [3:0] control,
    input [7:0] normal,
    input [127:0] hash_out,
    output reg [15:0] display_out
    );
    always @(posedge clk)
        begin
            if(control == 0)
            display_out = normal;
            else if(control > 8)
            display_out = 0;
            else
            begin
            if(control == 4'b0001)
            display_out = hash_out[15:0];
            else if(control == 4'b0010)
            display_out = hash_out[31:16];
            else if(control == 4'b0011)
            display_out = hash_out[47:32];
            else if(control == 4'b0100)
            display_out = hash_out[63:48];
            else if(control == 4'b0101)
            display_out = hash_out[79:64];
            else if(control == 4'b0110)
            display_out = hash_out[95:80];
            else if(control == 4'b0111)
            display_out = hash_out[111:96];
            else if(control == 4'b1000)
            display_out = hash_out[127:112];
            end
            
        end
endmodule
