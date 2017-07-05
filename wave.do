onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate -divider ALU
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate -divider PC
add wave -noupdate /MIPS_Processor_TB/DUV/ROMProgramMemory/Address
add wave -noupdate /MIPS_Processor_TB/DUV/ROMProgramMemory/RealAddress
add wave -noupdate /MIPS_Processor_TB/DUV/ROMProgramMemory/Instruction
add wave -noupdate /MIPS_Processor_TB/DUV/ProgramCounter/PCValue
add wave -noupdate /MIPS_Processor_TB/DUV/ProgramCounter/NewPC
add wave -noupdate -divider RAM
add wave -noupdate /MIPS_Processor_TB/DUV/RAMDataMemory/ram
add wave -noupdate /MIPS_Processor_TB/DUV/RAMDataMemory/RealAddress
add wave -noupdate -divider MEWB
add wave -noupdate -color Green /MIPS_Processor_TB/DUV/MEWB/MemToReg_M
add wave -noupdate -color Green /MIPS_Processor_TB/DUV/MEWB/RegWrite_M
add wave -noupdate /MIPS_Processor_TB/DUV/MEWB/MemToReg_W
add wave -noupdate /MIPS_Processor_TB/DUV/MEWB/RegWrite_W
add wave -noupdate -color Green /MIPS_Processor_TB/DUV/MEWB/ReadDataRAM_M
add wave -noupdate -color Green /MIPS_Processor_TB/DUV/MEWB/ALUResult_M
add wave -noupdate -color Green /MIPS_Processor_TB/DUV/MEWB/PC_4_M
add wave -noupdate -color Green /MIPS_Processor_TB/DUV/MEWB/WriteReg_M
add wave -noupdate /MIPS_Processor_TB/DUV/MEWB/ReadDataRAM_W
add wave -noupdate /MIPS_Processor_TB/DUV/MEWB/ALUResult_W
add wave -noupdate /MIPS_Processor_TB/DUV/MEWB/PC_4_W
add wave -noupdate /MIPS_Processor_TB/DUV/MEWB/WriteReg_W
add wave -noupdate -divider EXME
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/Jump_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/BranchEQ_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/BranchNE_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/MemRead_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/MemToReg_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/MemWrite_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/RegWrite_E
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/Jump_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/BranchEQ_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/BranchNE_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/MemRead_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/MemToReg_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/MemWrite_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/RegWrite_M
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/ALUResult_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/ReadData2_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/ReadData1_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/PC_4_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/BranchAdderResult_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/JumpAddress_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/WriteReg_E
add wave -noupdate -color {Blue Violet} /MIPS_Processor_TB/DUV/EXME/Zero_E
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/ALUResult_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/ReadData2_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/ReadData1_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/PC_4_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/BranchAdderResult_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/JumpAddress_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/WriteReg_M
add wave -noupdate /MIPS_Processor_TB/DUV/EXME/Zero_M
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {58 ps} {106 ps}
