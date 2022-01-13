
#====================================================================
#      Static data allocation and initialization - DO NOT MODIFY!
#====================================================================

.data

# Allocate space for the simulated registers.
registers: .space 128   # 32 registers x 4 bytes/register

# Allocate space for the program to simulate.
# For simplicity, we assume it won't be more than 50 instructions.
program:   .space 80   # 20 instructions x 4 bytes/instruction

#====================================================================
#       Program text
#====================================================================

.text
.globl main

main:
        # read number of instructions
        ori     $v0, $0, 5      # set up for readint syscall
        syscall                 # result will be in v0
        or      $s0, $0, $v0    # save count of number of instructions

        # loop reading instructions into simulated memory
        la $t0, program         # t0 now points at program memory

        # while (s0 > 0) read an instruction
rdPgm:  beq     $s0, $0, pgmReadDone
        ori     $v0, $0, 5      # prepare for readint call
        syscall
        sw      $v0, 0($t0)     # save instruction to program memory
        addi    $t0, $t0, 4     # increment pointer to next word of program memory
        addi    $s0, $s0, -1    # decrement count of number of instructions
        j       rdPgm

pgmReadDone:
        # initialize 0 to 0
        sw      $0, registers
        
        #  s0 will be the simulated PC.
        la $s0, program
 
        # now go into fetch/increment/decode/execute loop
        #   s0  - PC (as a pointer into program memory)
        #   t0  - IR (fetched instruction)
        #   t1  - 0x10 (literal value)
        ori     $t1, $0, 0x10   # halt opcode

fetchInst:          
        lw      $t0, 0($s0)     # fetch next instruction
        addi    $s0, $s0, 4     # increment PC
        
        #
        #---------------- YOUR CODE START HERE ... --------------------------
        #
	#get opcode(first 6 bits 31-26)
	srl t2, t0, 26
	#no need to mask since opcode is at end of inrtuction
	bne t2, 0x00, checkOtherinst	#if(opcode == 0x00)
					#its an r-instruction
	andi t3,t0, 0b111111		#get func, no need to srl since its at the front of inst
	bne t3, 0x20, checkSub 		#if(func == 0x20)#its add
		srl t4, t0, 21		#gets rs
		andi t4, t4, 0b11111
		srl t5, t0, 16		#gets rt
		andi t5, t5, 0b11111
		srl t6, t0, 11		#gets rd
		andi t6, t6, 0b11111
		mul t4, t4, 4 
		lw  t4,	registers(t4)	#loads rs
		mul t4, t4, 4 
		lw  t5,	registers(t5)	#loads rt
		add s1, t4, t5
		mul t6, t6, 4
		sw  s1, registers(t6)	#save them in rd 
		j end
		
checkSub:bne t3, 0x22, checkOr		#else if (func == 0x22) its sub
		srl t4, t0, 21		#gets rs
		andi t4, t4, 0b11111
		srl t5, t0, 16		#gets rt
		andi t5, t5, 0b11111
		srl t6, t0, 11		#gets rd
		andi t6, t6, 0b11111
		mul t4, t4, 4 
		lw  t4,	registers(t4)	#loads rs
		mul t4, t4, 4 
		lw  t5,	registers(t5)	#loads rt
		sub s2, t4, t5
		mul t6, t6, 4
		sw  s1, registers(t6)	#save them in rd 
		j end
checkOr:bne t3, 0x25, checkXor		#else if (func == 0x25) its or
		srl t4, t0, 21		#gets rs
		andi t4, t4, 0b11111
		srl t5, t0, 16		#gets rt
		andi t5, t5, 0b11111 
		srl t6, t0, 11		#gets rd
		andi t6, t6, 0b11111
		mul t4, t4, 4 
		lw  t4,	registers(t4)	#loads rs
		mul t4, t4, 4 
		lw  t5,	registers(t5)	#loads rt
		or  s3, t4, t5
		mul t6, t6, 4
		sw  s1, registers(t6)	#save them in rd 
		j end
checkXor:bne t3,0x26, checkOtherinst		#else if(func == 0x26) its xor 
		srl t4, t0, 21		#gets rs
		andi t4, t4, 0b11111
		srl t5, t0, 16		#gets rt
		andi t5, t5, 0b11111
		srl t6, t0, 11		#gets rd
		andi t6, t6, 0b11111
		mul t4, t4, 4 
		lw  t4,	registers(t4)	#loads rs
		mul t4, t4, 4 
		lw  t5,	registers(t5)	#loads rt
		xor s4, t4, t5 
		mul t6, t6, 4
		sw  s1, registers(t6)	#save them in rd 
		j end
	#else //its i-format
checkOtherinst:	srl t2, t0, 26		#get opcode
		bne t2, 0x04, checkAddi	#if(opcode == 0x04) its beq
			srl t4, t0, 21		#gets rs
			andi t4, t4, 0b11111
			srl t5, t0, 16		#gets rt
			andi t5, t5, 0b11111	
			andi t6, t4, 16		#gets immediate
			mul t4, t4, 4 
			lw  t4,	registers(t4)	#loads rs
			mul t4, t4, 4 
			lw  t5,	registers(t5)	#loads rt
			mul t5, t5, 4
			lw t6, registers(t6)	#loads immediate
			add s0, s0, t6		#increments PC
			j end
			
checkAddi:	bne t2, 0x08, end	#else if(opcode == 0x08) its addi
			srl t4, t0, 21		#gets rs
			andi t4, t4, 0b11111
			srl t5, t0, 16		#gets rt
			andi t5, t5, 0b11111
			andi t6, t4, 16		#gets immediate
			mul t4, t4, 4 
			lw  t4,	registers(t4)	#loads rs
			mul t4, t4, 4 
			lw  t5,	registers(t5)	#loads rt
			mul t5, t5, 4
			lw t6, registers(t6)	#loads immediate
			add s1, t6, t4
			j end
end:	
        # skeleton just looks for halt instruction
        srl     $t7, $t0, 26
        bne     $t7, $t1, fetchInst

        #
        #---------------- UP TO HERE ----------------------------------------
        #

# exit
li $v0, 10
syscall        

#notes
#s0 -> fake pc
#pc = pc + 4


