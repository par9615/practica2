/*Pipeline para la etapa de decode/execute

*/

module PipeDecode_Execute
(
	input clk,
	
	input [1:0]Jump_D,		
	input [1:0]RegDst_D,	
	input BranchEQ_D,
	input BranchNE_D,
	input MemRead_D,
	input [1:0]MemToReg_D, 
	input MemWrite_D,
	input ALUSrc_D,
	input RegWrite_D,
	input [1:0]ExtendSide_D,	
	input [2:0]ALUOp_D,
	
	output reg[1:0]Jump_E,		
	output reg[1:0]RegDst_E,	
	output reg BranchEQ_E,
	output reg BranchNE_E,
	output reg MemRead_E,
	output reg[1:0]MemToReg_E, 
	output reg MemWrite_E,
	output reg ALUSrc_E,
	output reg RegWrite_E,
	output reg[1:0]ExtendSide_E,	
	output reg[2:0]ALUOp_E,
	
	input [31:0]ReadData1_D,
	input [31:0]ReadData2_D,
	input [31:0]InmmediateExtend_D,
	input [4:0]Rt_D,
	input [4:0]Rd_D,
	
	output reg[31:0]ReadData1_E,
	output reg[31:0]ReadData2_E,
	output reg[31:0]InmmediateExtend_E,
	output reg[4:0]Rt_E,
	output reg[4:0]Rd_E
	
);



	always@(negedge clk)
	begin
		
		Jump_E = Jump_D;		
		RegDst_E = RegDst_D;
		BranchEQ_E = BranchEQ_D;
		BranchNE_E = BranchNE_D;
		MemRead_E = MemRead_D;
		MemToReg_E = MemToReg_D;
		MemWrite_E = MemWrite_D;
		ALUSrc_E = ALUSrc_D;
		RegWrite_E = RegWrite_D;
		ExtendSide_E = ExtendSide_D;
		ALUOp_E = ALUOp_D;

	end
	
	always@(negedge clk)
	begin
		
		ReadData1_E = ReadData1_D;
		ReadData2_E = ReadData2_D;
		InmmediateExtend_E = InmmediateExtend_D;
		Rt_E = Rt_D;
		Rd_E = Rd_D;

	end

endmodule