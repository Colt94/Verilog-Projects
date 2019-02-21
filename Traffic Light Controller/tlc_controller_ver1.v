`timescale 1ns / 1ps


module tlc_controller_ver1(
    output wire [1:0] highwaySignal,farmSignal,
    output wire [3:0] JB,
    input wire Clk,
    //buttons provide input
    input wire Rst,
    input wire farmSensor
    );
    
    wire RstSync;
    wire RstCount;
    reg [30:0] Count;
    
    assign JB[3] = RstCount;
    
    //synchronize button inputs
    synchronizer syncRst(RstSync,Rst,Clk);
    
    tlc_fsm FSM(
        .state(JB[2:0]),
        .RstCount(RstCount),
        .highwaySignal(highwaySignal),
        .farmSignal(farmSignal),
        .Count(Count),
        .Clk(Clk),
        .Rst(RstSync),
        .farmSensor(farmSensor)
        
    );
    
    always@(posedge Clk)
        if (RstCount || RstSync)
            Count = 0;
        else
            Count <= Count + 1;
        
endmodule
