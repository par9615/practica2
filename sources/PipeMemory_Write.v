/*Pipeline para la etapa de memory/write back

*/

module PipeMemory_Write
(
	input clk,
	
	//Control
	
	input [1:0]MemToReg_M, 
	input MemWrite_M,
	
	output reg[1:0]MemToReg_W, 
	output reg MemWrite_W,
	
	//Data
	
	input [31:0]ReadDataRAM_M,
	input [31:0]ALUResult_M,
	input [31:0]PC_4_M,
	input [4:0]WriteReg_M,
	
	output reg[31:0]ReadDataRAM_W,
	output reg[31:0]ALUResult_W,
	output reg[31:0]PC_4_W,
	output reg[4:0]WriteReg_W
	
);



	always@(negedge clk)
	begin		
		MemToReg_W = MemToReg_M;
		MemWrite_W = MemWrite_M;

	end
	
	always@(negedge clk)
	begin
		ReadDataRAM_W = ReadDataRAM_M;
		ALUResult_W = ALUResult_M;
		PC_4_W = PC_4_M;
		WriteReg_W = WriteReg_M;
	end
endmodule