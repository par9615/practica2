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
	output [1:0]Jump,		//00 no jump	//01 jump	//10 jr
	output [1:0]RegDst,	//00 rt 			//01 rd 		//10 31D
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output [1:0]MemToReg, //00 ALU		//01 RAM		//10 PC+4
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
localparam J_Type_JAL = 6'h03;

localparam R_Type_JR = 6'h08; 

reg [15:0] ControlValues;

always@(OP, Funct) begin
	casex(OP)
		R_Type:
			begin
				if (Funct == R_Type_JR)
					ControlValues = 16'b10_0_01_0_00_0_00_00_xxx;					
				else	
					ControlValues=  16'b00_0_01_0_00_1_00_00_111;					
			end
			
		I_Type_ADDI:  ControlValues= 16'b00_0_00_1_00_1_00_00_100;
		I_Type_ORI:   ControlValues= 16'b00_0_00_1_00_1_00_00_101;
		I_Type_LUI:   ControlValues= 16'b00_1_00_1_00_1_00_00_100;
		I_Type_BEQ:	  ControlValues= 16'b00_0_xx_0_xx_0_00_01_110;
		I_Type_BNE:	  ControlValues= 16'b00_0_xx_0_xx_0_00_10_110;		
		I_Type_SW: 	  ControlValues= 16'b00_0_xx_1_xx_0_01_00_100;
		I_Type_LW:    ControlValues= 16'b00_0_00_1_01_1_10_00_100;
		J_Type_JUMP:  ControlValues= 16'b01_0_00_0_00_0_00_00_xxx;
		J_Type_JAL:	  ControlValues= 16'b01_0_10_0_10_1_00_00_xxx;
		default:
			ControlValues= 16'b0000000000000000;
		endcase
end	

assign Jump[1] = ControlValues[15];
assign Jump[0] = ControlValues[14];

assign ExtendSide = ControlValues[13];

assign RegDst[1] = ControlValues[12];	
assign RegDst[0] = ControlValues[11];

assign ALUSrc = ControlValues[10];

assign MemToReg[1] = ControlValues[9];
assign MemToReg[0] = ControlValues[8];

assign RegWrite = ControlValues[7];

assign MemRead = ControlValues[6];
assign MemWrite = ControlValues[5];

assign BranchNE = ControlValues[4];
assign BranchEQ = ControlValues[3];

assign ALUOp = ControlValues[2:0];	

endmodule


