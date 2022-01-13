.data

arr: .word 1,2,3,4,5

.text


#get arr[2]
li $t0, 2
#t1 -> arr
la $t1, arr
#element size
li $t2, 1
#address offset
mul $t3, $t0, $t2
#t4 -> address of arr[2]
add $t4, $t1, 4t3

lw $t5,($t4)
li $v0, 1
move $a0, $t5
syscall
