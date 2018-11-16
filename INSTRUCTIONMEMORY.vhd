library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY INSTRUCTIONMEMORY IS
	GENERIC(	
		N : INTEGER := 32; -- PALAVRA: 4 B
		M : INTEGER := 64 -- 64 INSTRUCOES
	);
	
	PORT(	CLOCK 		: IN STD_LOGIC;
			PC				: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);				
			INSTRUCAO 	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END INSTRUCTIONMEMORY ;


ARCHITECTURE Behavior OF INSTRUCTIONMEMORY IS
	TYPE MEMORY_ARRAY IS ARRAY (0 TO M-1) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	
	CONSTANT ROM : MEMORY_ARRAY := (
		0  => "00010000100000000000000000000010", -- addi $1,$0,2
		1  => "00010001000000000000000000000100", -- addi $2,$0,4
		2  => "00010001100000000000000000001000", -- addi $3,$0,8
		3  => "00010010000000000000000000010000", -- addi $4,$0,16
		4  => "11111111111111111111111111111111", -- nop
		5  => "00010010100001000000000000000001", -- addi $5,$1,1
		6  => "00000011000001000110000000000000", -- add  $6,$1,$3
		7  => "00100011100001000000000100000000", -- subi $7,$1,256
		8  => "11111111111111111111111111111111", 
		9  => "11111111111111111111111111111111", 
		10 => "11111111111111111111111111111111", 
		11 => "11111111111111111111111111111111", 
		12 => "11111111111111111111111111111111", 
		13 => "00000100000110001000000000000001", -- sub $8,$6,$4
		14 => "00000100100001001010000000000010", -- and $9,$1,$5
		15 => "01100000000010000000000000000000", -- sw $2,0($0)
		16 => "01100000100011000000000000000000", -- sw $3,0($1)
		17 => "01010101000000000000000000000000", -- lw $10,0($0)
		18 => "01010101100000000000000000000010", -- lw $11,2($0)
		19 => "10000000000000000000000000011011", -- jmp 27
		20 => "11111111111111111111111111111111", 
		21 => "11111111111111111111111111111111", 
		22 => "11111111111111111111111111111111", 
		23 => "11111111111111111111111111111111", 
		24 => "11111111111111111111111111111111", 
		25 => "11111111111111111111111111111111", 
		26 => "11111111111111111111111111111111", 
		27 => "00010001000000000000000000010000", -- addi $2,$0,16
		28 => "00010000100001000000000000000001", -- addi $1,$1,1
		29 => "11111111111111111111111111111111", 
		30 => "11111111111111111111111111111111", 
		31 => "11111111111111111111111111111111", 
		32 => "11111111111111111111111111111111", 
		33 => "01110000100010000000000000001000", -- beq $1,$2,8
		34 => "11111111111111111111111111111111", 
		35 => "11111111111111111111111111111111", 
		36 => "11111111111111111111111111111111", 
		37 => "10000000000000000000000000010111", -- jmp 27
		38 => "11111111111111111111111111111111", 
		39 => "11111111111111111111111111111111", 
		40 => "11111111111111111111111111111111", 
		41 => "01110000100011000000000000000011", -- beq $1,$3,3 
		42 => "11111111111111111111111111111111",
		43 => "11111111111111111111111111111111", 
		44 => "11111111111111111111111111111111", 
		45 => "00010000100000000000000000111001", -- addi $1,$0,0
		46 => "11111111111111111111111111111111", 
		47 => "11111111111111111111111111111111", 
		48 => "11111111111111111111111111111111", 
		49 => "11111111111111111111111111111111", 
		50 => "00000000100000000000000000000100", -- jr $1
		51 => "11111111111111111111111111111111", 
		52 => "11111111111111111111111111111111", 
		53 => "11111111111111111111111111111111", 
		54 => "11111111111111111111111111111111", 
		55 => "11111111111111111111111111111111", 
		56 => "11111111111111111111111111111111", 
		57 => "11111111111111111111111111111111",  
		58 => "11111111111111111111111111111111", 
		59 => "11111111111111111111111111111111", 
		60 => "11111111111111111111111111111111", 
		61 => "11111111111111111111111111111111", 
		62 => "11111111111111111111111111111111", 
		63 => "10000000000000000000000000000000" -- jmp 0 
	);	
	
	SIGNAL INSTRUCAO_INTERNA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	PROCESS (CLOCK)
	BEGIN
		IF (CLOCK'EVENT AND CLOCK = '1') THEN		
				INSTRUCAO_INTERNA <= ROM(TO_INTEGER(UNSIGNED(PC)));
		END IF;
	END PROCESS ;
	
	INSTRUCAO <= INSTRUCAO_INTERNA;
END Behavior ;