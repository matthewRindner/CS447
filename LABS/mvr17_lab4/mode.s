	.data
# do not modify
LIST1:	
	.word 2 3 3 4 5 6 7 7 7 8
LIST2:	
	.word 1 3 4 4 5 6 6 9 9 9
LIST3:
	.word 35
received1:   
	.asciiz "LIST1: received "
received2:   
	.asciiz "LIST2: received "
received3:
	.asciiz "LIST3: received "
newline: 
	.asciiz "\n"
expected:
	.asciiz ", expected "
	
	.text

.globl main

main:
	# test case 1
	la a0 LIST1 # get address of the array
	li a1 10 # length of list
	jal mode
	move s0, v0
	la a0 received1
	li v0 4
	syscall # PRINT "LIST1: received "
	move a0 s0
	li v0 1
	syscall # PRINT value returned from call to mode
	la a0 expected
	li v0 4
	syscall # PRINT ", expected "
	li a0 7
	li v0 1
	syscall # PRINT expected result
	la a0 newline
	li v0 4
	syscall # PRINT newline
	
	# test case 2
	la a0 LIST2 # get address of the array
	li a1 10 # length of list
	jal mode
	move s0, v0
	la a0 received2
	li v0 4
	syscall # PRINT "LIST2: received "
	move a0 s0
	li v0 1
	syscall # PRINT value returned from call to mode
	la a0 expected
	li v0 4
	syscall # PRINT ", expected "
	li a0 9
	li v0 1
	syscall # PRINT expected result
	la a0 newline
	li v0 4
	syscall # PRINT newline

	# test case 3
	la a0 LIST3 # get address of the array
	li a1 1 # length of list
	jal mode
	move s0, v0
	la a0 received3
	li v0 4
	syscall # PRINT "LIST3: received "
	move a0 s0
	li v0 1
	syscall # PRINT value returned from call to mode
	la a0 expected
	li v0 4
	syscall # PRINT ", expected "
	li a0 35
	li v0 1
	syscall # PRINT expected result

	li v0 10
	syscall # EXIT
	
mode: # mode(a0,a1)
	# ****** YOUR CODE STARTS HERE ******
	#
        # a0 is the address of the list, and a1 is the length. <<<length>>>
        #
	# Try not to deviate too greatly (if at all) from the C version.
        #
	# DO NOT look up the values of the s registers, LIST,
        # etc from above. You will receive no credit if you do.
        #
        # This problem can be solved using only the a0-a3,t0-t?,
        # v0,ra registers.

	lw t1 0(a0) # currNum = arr[0]
        li t2 1 # count = 1
        move v0 t1 # mode = currNum
        li t3 0 # modeCount = 0
        li t4 1 # initialize i to 1
        
        # Begin your code here, starting at the for loop in the C code.
        lw	t6, 0(t4)	#loads arr[i] into t6
        subi	t7, a1, 1	#t7=len-1
                
	forLoop:
	bgt	t4, a1, end	#if(t4>a1) goto end
	beq	t6, t1, true	#if arr[i]== currNum
	j	false
true:	addi	t2, t2, 1	#count++
	addi	t4, t4, 1	#i++
false:	addi	t4, t4, 1	#i++	
	j	forLoop 
	end:
	#big conditional if statement
	beq	t4, t7, blockA
	bne	t6, t1, blockA
	j	skipA
blockA:	ble	t2, t3, afterIf	#branch of reg1<=reg2
	move	t3, t4		#modeCount = count
	move	v0, t1		#mode = currNum;
	afterIf:
	move	t1, t6		#currNum = arr[i]
	li	t2, 1		#count = 1
skipA:	jr ra		# return mode
	
