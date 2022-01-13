.data
    a: .word 0x1a1b1c1d

.text
.globl main
main:
la t1, a	#loads address into t1
addi t2, t1, 3	# t1+3=t2
lbu t3,(t2) 	#loads address into t3