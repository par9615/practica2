/*Pipeline para la etapa de execute/memory

*/

module PipeExecute_Memory
(
	input clk,
	
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

	
	input [31:0]ALUResult_E,
	input [31:0]WriteData_E,
	input [31:0]PCBranch_E,
	input [4:0]WriteReg_E,
	input Zero_E,
	
	output reg[31:0]ALUResult_M,
	output reg[31:0]WriteData_M,
	output reg[31:0]PCBranch_M,
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
		WriteData_M = WriteData_E;
		PCBranch_M = PCBranch_E;
		WriteReg_M = WriteReg_E;
		Zero_M = Zero_E;

	end

endmodule