`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2018 02:14:28 PM
// Design Name: 
// Module Name: SignExtender
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


module SignExtender(BusImm, Imm32); 
  output reg [63:0] BusImm; 
  input [31:0] Imm32;  

    always@ (*) begin
    if(Imm32[31:26] == 6'b000101 || Imm32[31:26] == 6'b100101)   
	   BusImm = {{38{Imm32[25]}} , Imm32[25:0]}; //extends the output to 64
    else if (Imm32[31:24] == 8'b01010100 || Imm32[31:24] == 8'b10110100 || Imm32[31:24] == 8'b10110101)
	   BusImm = {{45{Imm32[23]}}, Imm32[23:5]};
    else if (Imm32[31:21] == 11'b11111000000 || Imm32[31:21] == 11'b11111000010)
	   BusImm = {{55{Imm32[20]}}, Imm32[20:12]};   
    end

endmodule

