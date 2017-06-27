/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0]OP,
	input [5:0]Funct,
	output [1:0]Jump, //00 -no jump 01 jump 10 jr
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemToReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output ExtendSide,
	
	output [2:0]ALUOp
	
	
);
localparam R_Type = 0;
localparam I_Type_ADDI = 6'h8;
localparam I_Type_ORI = 6'h0d;
localparam I_Type_LUI = 6'h0f;
localparam I_Type_BEQ = 6'h04;
localparam I_Type_BNE = 6'h05;
localparam I_Type_SW = 6'h2b;
localparam I_Type_LW = 6'h23;
localparam J_Type_JUMP = 6'h02;

localparam R_Type_JR = 6'h08; 

reg [13:0] ControlValues;

always@(OP, Funct) begin
	casex(OP)
		R_Type:
			begin
				if (Funct == R_Type_JR)
					ControlValues = 14'b10_01_000_00_00_xxx;
					
				else	
					ControlValues= 14'b00_01_001_00_00_111;
					
			end
		I_Type_ADDI:  ControlValues= 14'b00_00_101_00_00_100;
		I_Type_ORI:   ControlValues= 14'b00_00_101_00_00_101;
		I_Type_LUI:   ControlValues= 14'b00_10_101_00_00_100;
		I_Type_BEQ:	  ControlValues= 14'b00_0x_0x0_00_01_110;
		I_Type_BNE:	  ControlValues= 14'b00_0x_0x0_00_10_110;		
		I_Type_SW: 	  ControlValues= 14'b00_0x_1x0_01_00_100;
		I_Type_LW:    ControlValues= 14'b00_00_111_10_00_100;
		J_Type_JUMP:  ControlValues= 14'b01_00_000_00_00_xxx;
		default:
			ControlValues= 14'b00000000000000;
		endcase
end	

assign Jump[1] = ControlValues[13];
assign Jump[0] = ControlValues[12];

assign ExtendSide = ControlValues[11];	
assign RegDst = ControlValues[10];

assign ALUSrc = ControlValues[9];
assign MemToReg = ControlValues[8];
assign RegWrite = ControlValues[7];

assign MemRead = ControlValues[6];
assign MemWrite = ControlValues[5];

assign BranchNE = ControlValues[4];
assign BranchEQ = ControlValues[3];

assign ALUOp = ControlValues[2:0];	

endmodule


