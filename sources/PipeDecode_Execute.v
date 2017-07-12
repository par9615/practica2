/*Pipeline para la etapa de decode/execute

*/

module PipeDecode_Execute
(
	input clk,
	
	//Control
	
	input [1:0]Jump_D,		
	input [1:0]RegDst_D,	
	input BranchEQ_D,
	input BranchNE_D,
	input MemRead_D,
	input [1:0]MemToReg_D, 
	input MemWrite_D,
	input ALUSrc_D,
	input RegWrite_D,
	input [3:0]ALUOperation_D,
		
	output reg[1:0]Jump_E,		
	output reg[1:0]RegDst_E,	
	output reg BranchEQ_E,
	output reg BranchNE_E,
	output reg MemRead_E,
	output reg[1:0]MemToReg_E, 
	output reg MemWrite_E,
	output reg ALUSrc_E,
	output reg RegWrite_E,	
	output reg[3:0]ALUOperation_E,
	
	//Data
	
	input [31:0]ReadData1_D,
	input [31:0]ReadData2_D,
	input [31:0]InmmediateExtend_D,
	input [31:0]JumpAddress_D,
	input [4:0]Rt_D,
	input [4:0]Rd_D,
	input [4:0]Rs_D,
	input [31:0]PC_4_D,
	input [4:0]Shamt_D,
	
	output reg[31:0]ReadData1_E,
	output reg[31:0]ReadData2_E,
	output reg[31:0]InmmediateExtend_E,
	output reg[31:0]JumpAddress_E,
	output reg[4:0]Rt_E,
	output reg [31:0]PC_4_E,
	output reg[4:0]Rd_E,
	output reg[4:0]Rs_E,
	output reg[4:0]Shamt_E
	
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
		ALUOperation_E = ALUOperation_D;

	end
	
	always@(negedge clk)
	begin
		
		ReadData1_E = ReadData1_D;
		ReadData2_E = ReadData2_D;
		InmmediateExtend_E = InmmediateExtend_D;
		Rt_E = Rt_D;
		Rd_E = Rd_D;
		Rs_E = Rs_D;
		Shamt_E = Shamt_D;
		JumpAddress_E= JumpAddress_D;
		PC_4_E = PC_4_D;

	end

endmodule