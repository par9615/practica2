/*Pipeline para la etapa de fetch/decode

*/

module PipeFetch_Decode
(
	input clk,
	input [31:0]Instruction_F,
	input [31:0]PC_4_F,
	
	output reg [31:0]Instruction_D,
	output reg [31:0]PC_4_D
);



	always@(negedge clk)
	begin
		
		Instruction_D = Instruction_F;
		PC_4_D = PC_4_F;		


	end

endmodule