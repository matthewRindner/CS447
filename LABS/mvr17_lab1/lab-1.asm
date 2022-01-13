.globl main   # <--- There is no "a" in globl!!!!!
main:

.data
 
.text
  li      a0,  0x4321
  li      v0, 1
  syscall
