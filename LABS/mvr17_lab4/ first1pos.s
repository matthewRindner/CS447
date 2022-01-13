
.globl main

main:
	lui	a0,0x8000	# should be 31
	jal	first1pos
	jal	printv0
	lui	a0,0x0001	# should be 16
	jal	first1pos
	jal	printv0
	li	a0,1		# should be 0
	jal	first1pos
	jal	printv0
	add	a0,$0,$0
	jal	first1pos
	jal	printv0
	li	v0,10
	syscall


first1pos:	# placeholder to call different versions: first1posshift of first1posmask
	addiu	sp, sp, -4
	sw	ra, 0(sp)
	jal	first1posshift
	lw	ra, 0(sp)
	addiu	sp, sp, 4
	jr	ra


first1posshift:
	li	t0, 0	#i=0
	li	t1, 1	#t1 = 1
	li	t2, 31
	
	beq	t0, t2, startLoop
	j	exit
startLoop:	
	
loop:	blt	a0, t1, true	#if(a0 < 1)
	j	false
true:	#return index
	jr ra

false:	sll	a0, a0, 1	#shift left
	addi	t0, t0, 1	#i++
	j	loop
exit:			#1 not found


first1posmask:


printv0:
	addi	sp,sp,-4
	sw	ra,0(sp)
	add	a0,v0,0
	li	v0,1
	syscall
	li	v0,11
	li	a0,'\n'
	syscall
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra
