// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// RAM[2] = RAM[0] * RAM[1]

// Initialization of register for storing results
@2
M=0

@1
D=M       // D = RAM[1]
@counter
M=D       // RAM[counter] = RAM[1]    

(LOOP)
	@counter
	D=M
	@END
	D;JEQ     // if counter == 0 then end loop
	@0
	D=M       // D = RAM[0]（multiplicand）
	@2
	M=M+D     // RAM[2] += RAM[0]
	@counter
	M=M-1
	@LOOP
	0;JMP     // To the top of the loop again
(END)
	@END
	0;JMP     // Ends in an infinite loop.