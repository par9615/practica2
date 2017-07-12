module Forwarding
(
	input [4:0]Rs_E,
	input [4:0]Rt_E,
		
	input RegWrite_M,
	input [4:0]WriteReg_M,
	
	input RegWrite_W,
	input [4:0]WriteReg_W,
	
	output reg[1:0]ForwardA,
	output reg[1:0]ForwardB

);

	//Forward A
	always@(Rs_E, RegWrite_M, WriteReg_M, RegWrite_W, WriteReg_W)
	begin
		
		if(RegWrite_M && (WriteReg_M != 0) && (WriteReg_M == Rs_E))
			ForwardA = 2'b01;
		else if(RegWrite_W && (WriteReg_W != 0) && (WriteReg_W == Rs_E))
			ForwardA = 2'b10;
		else
			ForwardA = 2'b00;	
	end

	//Forward B
	always@(Rt_E, RegWrite_M, WriteReg_M, RegWrite_W, WriteReg_W)
	begin
		
		if(RegWrite_M && (WriteReg_M != 0) && (WriteReg_M == Rt_E))
			ForwardB = 2'b01;
		else if(RegWrite_W && (WriteReg_W != 0) && (WriteReg_W == Rt_E))
			ForwardB = 2'b10;
		else
			ForwardB = 2'b00;	
	end




endmodule
