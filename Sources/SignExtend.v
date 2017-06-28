/******************************************************************
* Description
*	This module performes a sign-extend operation that is need with
*	in instruction like andi or ben.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module SignExtend
(  input [1:0]ExtendSide ,
	input [15:0]  DataInput,
   output reg[31:0] SignExtendOutput
);

//assign  SignExtendOutput = {{16{DataInput[15]}},DataInput[15:0]};

always @(ExtendSide,DataInput)	
begin
	case(ExtendSide)
		2'b00:
			SignExtendOutput = {{16{DataInput[15]}},DataInput[15:0]};
		2'b01:
			SignExtendOutput = {DataInput[15:0],16'b0000000000000000};		
		2'b10:
			SignExtendOutput = {16'b0000000000000000,DataInput[15:0]};
		default:
			SignExtendOutput = 32'b00000000000000000000000000000000;
	endcase
	
		
	
end							  
								  
								  

endmodule // signExtend
