/*	This is the top-level of a MIPS processor that can execute the next set of instructions:
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
	parameter MEMORY_DEPTH = 512
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

wire BranchEQ_XOR_BranchNE_wire; 


wire [31:0] MUX_PC_wire;
wire [31:0] PC_wire;
wire [2:0] ALUOp_wire;

wire [31:0] ReadData2OrInmmediate_wire;

wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCtoBranch_wire;
wire [31:0] ShiftLeft2_Branch_wire;

wire [31:0] MUX_Branch_Result;
wire [31:0] MUX_Jump_Result;
wire [31:0] MUX_ALURAM_Result;

integer ALUStatus;

//fetch_stage
wire [31:0] Instruction_F;
wire [31:0] PC_4_F;

//decode_stage
wire BranchNE_D;
wire BranchEQ_D;
wire [1:0]RegDst_D;
wire ALUSrc_D;
wire RegWrite_D;
wire [1:0]ExtendSide_D;
wire [1:0]Jump_D;
wire MemRead_D;
wire MemWrite_D;
wire [1:0]MemToReg_D;

wire [31:0]ReadData1_D;
wire [31:0]ReadData2_D;
wire [31:0]InmmediateExtend_D;
wire [31:0]Instruction_D;
wire [31:0]PC_4_D;
wire [31:0]JumpAddress_D;
wire [4:0]Rd_D; 
assign Rd_D = Instruction_D[15:11];
wire [4:0]Rt_D;
assign Rt_D = Instruction_D[20:16];
wire [4:0]Rs_D;
assign Rs_D = Instruction_D[25:21];
wire [3:0]ALUOperation_D;

//execute_stage
wire BranchNE_E;
wire BranchEQ_E;
wire [1:0]RegDst_E;
wire ALUSrc_E;
wire RegWrite_E;
wire [1:0]Jump_E;
wire MemRead_E;
wire MemWrite_E;
wire [1:0]MemToReg_E;

wire [31:0]BranchAdderResult_E;
wire [31:0]ALUResult_E;
wire [31:0]PC_4_E;
wire [31:0]ReadData1_E;
wire [31:0]ReadData2_E;
wire [31:0]InmmediateExtend_E;
wire [31:0]PCBranch_E;
wire [31:0]WriteData_E;
wire [31:0]ShiftLeft2_Jump_E;
wire [31:0]JumpAddress_E;
wire [4:0]WriteReg_E;
wire [4:0]Shamt_E;
wire [4:0]Rd_E;
wire [4:0]Rt_E;
wire [4:0]Rs_E;
wire [3:0]ALUOperation_E;
wire Zero_E;

//memory_stage
wire [1:0]MemToReg_M;
wire [1:0]Jump_M;
wire MemWrite_M;
wire MemRead_M;
wire BranchNE_M;
wire BranchEQ_M;
wire RegWrite_M;
wire Zero_M;

wire [31:0]ReadData1_M;
wire [31:0]ReadData2_M;
wire [31:0]JumpAddress_M;
wire [31:0]BranchAdderResult_M;
wire [31:0]ReadDataRAM_M;
wire [31:0]ALUResult_M;
wire [31:0]PC_4_M;
wire [4:0]WriteReg_M;

//writeback_stage
wire [1:0]MemToReg_W;
wire RegWrite_W;

wire [31:0]ReadDataRAM_W;
wire [31:0]ALUResult_W;
wire [31:0]PC_4_W;
wire [4:0]WriteReg_W;



//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
ControlUnit
(
	.ALUOp(ALUOp_wire),
	.Funct(Instruction_D[5:0]),
	.OP(Instruction_D[31:26]),
	.RegDst(RegDst_D),
	.BranchNE(BranchNE_D),
	.BranchEQ(BranchEQ_D),	
	.ALUSrc(ALUSrc_D),
	.RegWrite(RegWrite_D),
	.ExtendSide(ExtendSide_D),
	.Jump(Jump_D),
	.MemWrite(MemWrite_D),
	.MemRead(MemRead_D),
	.MemToReg(MemToReg_D)
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
	.Address(PC_wire),//aqui falta algo
	.Instruction(Instruction_F)
);

Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	
	.Result(PC_4_F)
);


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer3to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_E),
	.MUX_Data0(Rt_E), 
	.MUX_Data1(Rd_E), 
	.MUX_Data2(5'd31),
	
	.MUX_Output(WriteReg_E)
);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_W), //Conectar desde pipeline MEWB
	.WriteRegister(WriteReg_W),
	.ReadRegister1(Instruction_D[25:21]),
	.ReadRegister2(Instruction_D[20:16]),
	.WriteData(MUX_ALURAM_Result), //Se conecta en MEWB, pero ya está
	.ReadData1(ReadData1_D),
	.ReadData2(ReadData2_D)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_D[15:0]),
   .SignExtendOutput(InmmediateExtend_D),
	.ExtendSide(ExtendSide_D)
);



Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_E),
	.MUX_Data0(ReadData2_E),
	.MUX_Data1(InmmediateExtend_E),	
	.MUX_Output(ReadData2OrInmmediate_wire)

);



ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire),
	.ALUFunction(Instruction_D[5:0]),
	.ALUOperation(ALUOperation_D)

);



ALU
ArithmeticLogicUnit 
(
	.Shamt(Shamt_E), 
	.ALUOperation(ALUOperation_E),
	.A(ReadData1_E),
	.B(ReadData2OrInmmediate_wire),
	.Zero(Zero_E), 
	.ALUResult(ALUResult_E) 
);


/**********************************/
/*************BEQ y BNE******************/
/**********************************/
ShiftLeft2
ShiftBranch
(
	.DataInput(InmmediateExtend_E),
	.DataOutput(ShiftLeft2_Branch_wire)

);

Adder32bits
BranchAdder
(
	.Data0(PC_4_E),
	.Data1(ShiftLeft2_Branch_wire),
	.Result(BranchAdderResult_E) 
);



Multiplexer2to1
MUX_ForBranchOrPC
(
	.MUX_Data0(PC_4_F), 
	.MUX_Data1(BranchAdderResult_M), 
	.Selector(BranchEQ_XOR_BranchNE_wire), 
	.MUX_Output(MUX_Branch_Result) 
);


/**********************************/
/*************JUMPS******************/
/**********************************/
ShiftLeft2
ShiftJump
(
	.DataInput(JumpAddress_E), 
	.DataOutput(ShiftLeft2_Jump_E)
);


Multiplexer3to1
MUX_ForJumpOrBranch
(
	.MUX_Data0(MUX_Branch_Result), //falta cambiar
	.MUX_Data1(JumpAddress_M), //hace falta cambiar
	.MUX_Data2(ReadData1_M), //falta cambiar
	.Selector(Jump_D), //falta cambiar
	.MUX_Output(MUX_Jump_Result) //falta cambiar
);

/**********************************/
/*************SW y LW******************/
/**********************************/

DataMemory
#(
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
RAMDataMemory
( 	
	.WriteData(ReadData2_M), //incompleto, y creo que al Pipeline Exec - Memory tambien
	.Address(ALUResult_M),
	.MemWrite(MemWrite_M),
	.MemRead(MemRead_M),
	.ReadData(ReadDataRAM_M),
	.clk(clk)
);

Multiplexer3to1
MUX_ForALUOrRAM
(

	.MUX_Data0(ALUResult_W),
	.MUX_Data1(ReadDataRAM_W),
	.MUX_Data2(PC_4_W),
	
	.MUX_Output(MUX_ALURAM_Result),
	.Selector(MemToReg_W)	
	
);


/**************PIPELINES***************/
/**************************************/

// Fetch -> Decode
PipeFetch_Decode
FEDE
(
	.clk(clk),
	
	//data
	.Instruction_F(Instruction_F),
	.PC_4_F(PC_4_F),
	
	.Instruction_D(Instruction_D),
	.PC_4_D(PC_4_D)
);

// Decode -> Execute
PipeDecode_Execute
DEEX
(	
	.clk(clk),
	
	//control
	.Jump_D(Jump_D),	
	.RegDst_D(RegDst_D),	
	.BranchEQ_D(BranchEQ_D),
	.BranchNE_D(BranchNE_D),	
	.MemRead_D(MemRead_D),
	.MemToReg_D(MemToReg_D), 
	.MemWrite_D(MemWrite_D),
	.ALUSrc_D(ALUSrc_D),
	.RegWrite_D(RegWrite_D),		
	.ALUOperation_D(ALUOperation_D),
	
	.Jump_E(Jump_E),	
	.RegDst_E(RegDst_E),	
	.BranchEQ_E(BranchEQ_E),
	.BranchNE_E(BranchNE_E),	
	.MemRead_E(MemRead_E),
	.MemToReg_E(MemToReg_E), 
	.MemWrite_E(MemWrite_E),
	.ALUSrc_E(ALUSrc_E),
	.RegWrite_E(RegWrite_E),	
	.ALUOperation_E(ALUOperation_E),
	
	//data	
	.ReadData1_D(ReadData1_D),
	.ReadData2_D(ReadData2_D),
	.InmmediateExtend_D(InmmediateExtend_D),
	.Rt_D(Rt_D),
	.Rd_D(Rd_D),
	.Rs_D(Rs_D),
	.PC_4_D(PC_4_D),
	.Shamt_D(Instruction_D[10:6]),
	.JumpAddress_D(Instruction_D[25:0]),
	
	.ReadData1_E(ReadData1_E),
	.ReadData2_E(ReadData2_E),
	.InmmediateExtend_E(InmmediateExtend_E),
	.Rt_E(Rt_E),
	.Rd_E(Rd_E),
	.Rs_E(Rs_E),
	.PC_4_E(PC_4_E),
	.Shamt_E(Shamt_E),
	.JumpAddress_E(JumpAddress_E)
	
);

// Execute -> Memory
PipeExecute_Memory
EXME
(
	.clk(clk),
	
	//control	
	.Jump_E(Jump_E),			
	.BranchEQ_E(BranchEQ_E),
	.BranchNE_E(BranchNE_E),
	.MemRead_E(MemRead_E),
	.MemToReg_E(MemToReg_E), 
	.MemWrite_E(MemWrite_E),
	.RegWrite_E(RegWrite_E),
	
	.Jump_M(Jump_M),			
	.BranchEQ_M(BranchEQ_M),
	.BranchNE_M(BranchNE_M),
	.MemRead_M(MemRead_M),
	.MemToReg_M(MemToReg_M), 
	.MemWrite_M(MemWrite_M),
	.RegWrite_M(RegWrite_M),
	
	//data
	.JumpAddress_E({PC_4_E[31:28],ShiftLeft2_Jump_E[27:0]}),
	.BranchAdderResult_E(BranchAdderResult_E),
	.ALUResult_E(ALUResult_E),
	.ReadData1_E(ReadData1_E),
	.ReadData2_E(ReadData2_E),
	.WriteReg_E(WriteReg_E),
	.PC_4_E(PC_4_E),
	.Zero_E(Zero_E),
	
	.BranchAdderResult_M(BranchAdderResult_M),
	.JumpAddress_M(JumpAddress_M),
	.ALUResult_M(ALUResult_M),
	.ReadData1_M(ReadData1_M),
	.ReadData2_M(ReadData2_M),
	.WriteReg_M(WriteReg_M),
	.PC_4_M(PC_4_M),
	.Zero_M(Zero_M)
	
);


// Memory -> Writeback
PipeMemory_Write
MEWB
(
	.clk(clk),
	
	//control	
	.MemToReg_M(MemToReg_M),
	.RegWrite_M(RegWrite_M),


	.MemToReg_W(MemToReg_W),
	.RegWrite_W(RegWrite_W),	
	
	//data	
	.ReadDataRAM_M(ReadDataRAM_M),
	.ALUResult_M(ALUResult_M),
	.PC_4_M(PC_4_M),
	.WriteReg_M(WriteReg_M),
	
	.ReadDataRAM_W(ReadDataRAM_W),
	.ALUResult_W(ALUResult_W),
	.PC_4_W(PC_4_W),
	.WriteReg_W(WriteReg_W)
	
);



//hace falta cambiar el segundo
assign ALUResultOut = ALUResult_E;
assign BranchEQ_XOR_BranchNE_wire = (BranchEQ_M&Zero_M) ^ (BranchNE_M & ~ Zero_M);

endmodule

