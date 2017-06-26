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
	output Jump,
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
localparam I_Type_SW = 6'h2b;
localparam I_Type_LW = 6'h23;
localparam J_Type_JUMP = 6'h02;

 

reg [12:0] ControlValues;

always@(OP) begin
	casex(OP)
		R_Type:       ControlValues= 13'b001_001_00_00_111;
		I_Type_ADDI:  ControlValues= 13'b000_101_00_00_100;
		I_Type_ORI:   ControlValues= 13'b000_101_00_00_101;
		I_Type_LUI:   ControlValues= 13'b010_101_00_00_100;
		I_Type_BEQ:	  ControlValues= 13'b00x_0x0_00_01_110;
		I_Type_SW: 	  ControlValues= 13'b00x_1x0_01_00_100;	
		J_Type_JUMP:  ControlValues= 13'b100_000_00_00_xxx;
		default:
			ControlValues= 13'b0000000000000;
		endcase
end	

assign Jump = ControlValues[12];
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


