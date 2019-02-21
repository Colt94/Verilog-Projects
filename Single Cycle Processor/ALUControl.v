`timescale 1ns / 1ps


module ALUControl(ALUCtrl, ALUop, Opcode);
    input [1:0] ALUop;
    input [10:0] Opcode;
    output [3:0] ALUCtrl;
    
    reg [3:0] out; //need a reg to operate in always block
    
    
    always @(*) begin 
        case(ALUop)
            2'b00: begin //LDUR or STUR
                out <= #2 4'b0010;
                end
            2'b01: begin //CBZ
                out <= #2 4'b0111;
                end
            2'b10: begin
                if(Opcode == 11'b10001011000) // ADD
                    out <= #2 4'b0010;
                else if(Opcode == 11'b11001011000) //SUB
                    out <= #2 4'b0110;
                else if(Opcode == 11'b10001010000) //AND
                    out <= #2 4'b0000;
                else if(Opcode == 11'b10101010000) //ORR
                    out <= #2 4'b0001;
                end

        endcase
    end
    assign #2 ALUCtrl = out;   //assign ALUCtrl to output 
    
endmodule
