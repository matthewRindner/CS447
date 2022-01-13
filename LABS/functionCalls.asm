.data

.globl main

.text

main:

li s0, 4
#call add_two(4)
move a0, s0
jal add_two

#store return value in s1
move v0, s0

li v0, 1
move a0, s1
syscall

#exit
li v0, 10
syscall

#takes one input and returns +2
add_two:

#addi sp, sp, -8
#sw s0, 0(sp)
#sw s1, 4(sp)

push s0
push s1

move s0, a0
addi s0, s0, 2
move v0, s0

pop s1
pop s0

#lw s1, 4(sp)
#lw s0, 0(sp)
#addi sp, sp, 8

jr ra
