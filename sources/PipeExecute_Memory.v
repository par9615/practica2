/*Pipeline para la etapa de execute/memory

*/

module PipeExecute_Memory
(
	input clk,
	
	//Control
	
	input [1:0]Jump_E,			
	input BranchEQ_E,
	input BranchNE_E,
	input MemRead_E,
	input [1:0]MemToReg_E, 
	input MemWrite_E,
	input RegWrite_E,
	
	output reg[1:0]Jump_M,
	output reg BranchEQ_M,
	output reg BranchNE_M,
	output reg MemRead_M,
	output reg[1:0]MemToReg_M, 
	output reg MemWrite_M,
	output reg RegWrite_M,

	//Data
	
	input [31:0]ALUResult_E,
	input [31:0]MUX_ForwardB_Result_E,
	input [31:0]ReadData1_E,
	input [31:0]PC_4_E,
	input [31:0]BranchAdderResult_E,
	//input [31:0]ShiftLeft2_Jump_E,
	input [31:0]JumpAddress_E,
	input [4:0]WriteReg_E,
	input Zero_E,
	
	output reg[31:0]ALUResult_M,
	output reg[31:0]ReadData1_M,
	output reg[31:0]MUX_ForwardB_Result_M,
	output reg[31:0]PC_4_M,
	output reg[31:0]BranchAdderResult_M,
	//output reg[31:0]ShiftLeft2_Jump_M,
	output reg[31:0]JumpAddress_M,
	output reg[4:0]WriteReg_M,
	output reg Zero_M
);



	always@(negedge clk)
	begin
		
		Jump_M = Jump_E;
		BranchEQ_M = BranchEQ_E;
		BranchNE_M = BranchNE_E;
		MemRead_M = MemRead_E;
		MemToReg_M = MemToReg_E;
		MemWrite_M = MemWrite_E;	
		RegWrite_M = RegWrite_E;


	end
	
	always@(negedge clk)
	begin
		
		ALUResult_M= ALUResult_E;
		ReadData1_M = ReadData1_E;
		MUX_ForwardB_Result_M = MUX_ForwardB_Result_E;
		PC_4_M = PC_4_E;
		WriteReg_M = WriteReg_E;
		BranchAdderResult_M = BranchAdderResult_E;
		//ShiftLeft2_Jump_M = ShiftLeft2_Jump_E;
		JumpAddress_M = JumpAddress_E;
		Zero_M = Zero_E;

	end

endmodule