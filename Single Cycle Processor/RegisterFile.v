`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 06:42:58 PM
// Design Name: 
// Module Name: RegisterFile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output[63:0] BusA;
    output[63:0] BusB;
    input [63:0] BusW;
    input [4:0] RB, RA, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];
  
    
    assign #2 BusA = (RA == 5'd31)?64'b0: registers[RA];
    assign #2 BusB = (RB == 5'd31)?64'b0: registers[RB];
     
    always @ (negedge Clk) begin
        if(RegWr && RW != 5'd31)
            registers[RW] <= #3 BusW;
    end
 
            
endmodule

