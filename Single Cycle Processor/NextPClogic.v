`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 09:45:29 PM
// Design Name: 
// Module Name: NextPClogic
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


module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output reg [63:0] NextPC; 
       
      
       always @(*)
           begin
               if(Uncondbranch)
                   NextPC <= #2 (SignExtImm64 << 2) + CurrentPC; //next PC is specified address
               else if(Branch == 1'b1 && ALUZero == 1'b1)
                   NextPC <= #2 (SignExtImm64 << 2) + CurrentPC; // shift sign extend left 2 and add to current PC
               else
                   NextPC <= #2 CurrentPC + 4; //PC = PC + 4
       
           end
       
endmodule
