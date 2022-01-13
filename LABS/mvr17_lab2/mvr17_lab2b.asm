.data
  str1: .asciiz "What is the first value?\n"
  str2: .asciiz "What is the second value?\n"
  str3: .asciiz "trdfjgkhlj;k\n"

  # First Input
  a:   .word 0
  b:   .word 0
  c:   .word 0

.text
.globl main
main:
  la a0, str1    # printString(str)
  li v0, 4
  syscall

  li v0, 5      # a = getInteger()
  syscall
  sw v0, a


  li v0, 1      # a = printInteger(a)
  lw a0, a
  syscall
  
  li v0, 11     # a = printChar('\n')
  li a0, '\n'
  syscall
  
  la a0, str2    # printString(str2)
  li v0, 4
  syscall  
  
  li v0, 5      # a = getInteger()
  syscall
  sw v0, b
  
  li v0, 1      # a = printInteger(b)
  lw a0, b
  syscall
  
  li v0, 11     # a = printChar('\n')
  li a0, '\n'
  syscall
  
  lw t0, a
  lw, t1, b
  add t2, t1, t0
  sw t2, c
  
  li v0, 1      # a = printInteger(c)
  la a0, c
  syscall
  
  li v0, 10     # exit() - stops the program
  syscall