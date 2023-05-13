`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Flag_Control clrFlag(
//    .chal(),
//    .btn(),
//    .clr_done(),
//    .clr());
//////////////////////////////////////////////////////////////////////////////////


module Flag_Control(
    input clk,
    input [7:0] chal,
    input btn,
    input clr_done,
    output reg clr
    );

    reg init = 0;
    reg [7:0] old_chal = 0;
    reg old_btn = 0;
    reg chal_clr, btn_clr;
    
    always @(posedge clk)
    begin
    
    if(clr_done == 1)
    clr = 1'b0;
    
    if(init == 0)begin
        old_chal = chal;
        init = init + 1;
    end
    else if(init != 0)begin
        if(chal != old_chal)begin
            clr = 1'b1;
            old_chal = chal;
        end

    end
    if(old_btn != btn)
        clr = 1'b1;

    end
    
endmodule
