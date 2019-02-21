`timescale 1ns / 1ps
`default_nettype none
`define one_sec 50000000
`define thirty_sec 1500000000
`define three_sec 150000000
`define fifteen_sec 750000000
//////////////////////////////////////////////////////////////////////////////////


module tlc_fsm(
    output reg [2:0] state, //output for testing
    output reg RstCount, //use an always block
    output reg [1:0] highwaySignal, farmSignal,
    input wire [30:0] Count,
    input wire Clk, Rst,
    input wire farmSensor
 );
 
 
 
 parameter S0 = 3'b000,
           S1 = 3'b001,
           S2 = 3'b010,
           S3 = 3'b011,
           S4 = 3'b100,
           S5 = 3'b101;
           
           
reg [2:0] nextState;

always@(*)
    case(state)
    S0: begin 
        highwaySignal = 2'b01;
        farmSignal = 2'b01;
        if (Count == `one_sec)
            begin
            nextState = S1;
            RstCount = 1;
            end
        else
            begin
            nextState = S0;
            RstCount = 0;
            end
        end
    S1: begin
        highwaySignal = 2'b11;
        farmSignal = 2'b01;
        if (Count >= `thirty_sec && farmSensor == 1)
            begin 
            nextState = S2;
            RstCount = 1;
            end
        else
            begin
            nextState = S1;
            RstCount = 0;
            end
       end
     S2: begin
        highwaySignal = 2'b10;
        farmSignal = 2'b01;
        if (Count == `three_sec)
            begin 
            nextState = S3;
            RstCount = 1;
            end
        else
            begin
            nextState = S2;
            RstCount = 0;
            end
        end
  S3: begin
    highwaySignal = 2'b01;
    farmSignal = 2'b01;
        if (Count == `one_sec)
            begin 
            nextState = S4;
            RstCount = 1;
            end
        else
            begin
            nextState = S3;
            RstCount = 0;
            end
      end
  S4: begin
    highwaySignal = 2'b01;
    farmSignal = 2'b11;
    if ((Count == `three_sec && farmSensor == 0) || Count == `fifteen_sec)
        begin 
        nextState = S5;
        RstCount = 1;
        end
    else
        begin
        nextState = S4;
        RstCount = 0;
        end
    
    end
  S5: begin
    highwaySignal = 2'b01;
    farmSignal = 2'b10;
      if (Count == `three_sec)
          begin 
          nextState = S0;
          RstCount = 1;
          end
      else
          begin
          nextState = S5;
          RstCount = 0;
          end
      end
    
endcase

always@(posedge Clk)
    if(Rst)
    begin
        state <= S0;
        //assign Count = 0
    end
    else
        begin
        state <= nextState;
        //assign Count = Count + 1;
        end
endmodule
