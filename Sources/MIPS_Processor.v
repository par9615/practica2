/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		bne
*		beq
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2016
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 32
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
//******************************************************************/
//******************************************************************/
assign  PortOut = 0;

//******************************************************************/
//******************************************************************/
// Data types to connect modules
wire BranchNE_wire;
wire BranchEQ_wire;
wire RegDst_wire;
wire BranchEQ_XOR_BranchNE_wire;
wire ORForBranch;
wire ALUSrc_wire;
wire RegWrite_wire;
wire Zero_wire;
wire ExtendSide_wire;
wire Jump_wire;
wire MemRead_wire;
wire MemWrite_wire;
wire MemToReg_wire;

wire [2:0] ALUOp_wire;
wire [3:0] ALUOperation_wire;
wire [4:0] WriteRegister_wire;
wire [31:0] MUX_PC_wire;
wire [31:0] PC_wire;
wire [31:0] Instruction_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] ALUResult_wire;
wire [31:0] PC_4_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCtoBranch_wire;

wire [31:0] ShiftLeft2_Branch_wire;
wire [31:0] BranchAdder_Result;
wire [31:0] MUX_Branch_Result;

wire [31:0] MUX_Jump_Result;
wire [31:0] ShiftLeft2_Jump_wire;

wire [31:0] MUX_ALURAM_Result;
wire [31:0] ReadDataRAM_wire;
integer ALUStatus;


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
ControlUnit
(
	.ALUOp(ALUOp_wire),
	.OP(Instruction_wire[31:26]),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),	
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire),
	.ExtendSide(ExtendSide_wire),
	.Jump(Jump_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.MemToReg(MemToReg_wire)
);

PC_Register
ProgramCounter
(
	.clk(clk),
	.reset(reset),
	.NewPC(MUX_Jump_Result),
	.PCValue(PC_wire)
);


ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(PC_wire),
	.Instruction(Instruction_wire)
);

Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	
	.Result(PC_4_wire)
);


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction_wire[20:16]),
	.MUX_Data1(Instruction_wire[15:11]),
	
	.MUX_Output(WriteRegister_wire)

);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_wire),
	.WriteRegister(WriteRegister_wire),
	.ReadRegister1(Instruction_wire[25:21]),
	.ReadRegister2(Instruction_wire[20:16]),
	.WriteData(MUX_ALURAM_Result),
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire[15:0]),
   .SignExtendOutput(InmmediateExtend_wire),
	.ExtendSide(ExtendSide_wire)
);



Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire),
	.MUX_Data0(ReadData2_wire),
	.MUX_Data1(InmmediateExtend_wire),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);



ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire),
	.ALUFunction(Instruction_wire[5:0]),
	.ALUOperation(ALUOperation_wire)

);



ALU
ArithmeticLogicUnit 
(
	.Shamt(Instruction_wire[10:6]),
	.ALUOperation(ALUOperation_wire),
	.A(ReadData1_wire),
	.B(ReadData2OrInmmediate_wire),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);


/**********************************/
/*************BEQ******************/
/**********************************/
ShiftLeft2
ShiftBranch
(
	.DataInput(InmmediateExtend_wire),
	.DataOutput(ShiftLeft2_Branch_wire)

);

Adder32bits
BranchAdder
(
	.Data0(PC_4_wire),
	.Data1(ShiftLeft2_Branch_wire),
	.Result(BranchAdder_Result)
);



Multiplexer2to1
MUX_ForBranchOrPC
(
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(BranchAdder_Result),
	.Selector(BranchEQ_XOR_BranchNE_wire),
	.MUX_Output(MUX_Branch_Result)
);


/**********************************/
/*************J******************/
/**********************************/
ShiftLeft2
ShiftJump
(
	.DataInput(Instruction_wire[25:0]),
	.DataOutput(ShiftLeft2_Jump_wire)
);


Multiplexer2to1
MUX_ForJumpOrBranch
(
	.MUX_Data0(MUX_Branch_Result),
	.MUX_Data1({PC_4_wire[31:28],ShiftLeft2_Jump_wire[27:0]}),
	.Selector(Jump_wire),
	.MUX_Output(MUX_Jump_Result)
);

/**********************************/
/*************SW******************/
/**********************************/

DataMemory
#(
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(256)
)
RAMDataMemory
(
	.WriteData(ReadData2_wire),
	.Address(ALUResult_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.ReadData(ReadDataRAM_wire),
	.clk(clk)
);

Multiplexer2to1
MUX_ForALUOrRAM
(
	.MUX_Data0(ALUResult_wire),
	.MUX_Data1(ReadDataRAM_wire),
	.MUX_Output(MUX_ALURAM_Result),
	.Selector(MemToReg_wire)
	
);



assign ALUResultOut = ALUResult_wire;
assign BranchEQ_XOR_BranchNE_wire = (BranchEQ_wire&Zero_wire) ^ (BranchNE_wire & ~ Zero_wire);

endmodule

