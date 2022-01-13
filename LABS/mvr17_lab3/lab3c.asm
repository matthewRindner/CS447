.data
  myArray: .word 0, 4, -3, 5, 2, -1, 6, 15, -8, 10
  # Declare your variables here
  # // add your code //
  str1: 	.asciiz "Please enter a number from 0 to 9\n"
  str2: 	.asciiz "Please enter a different number from 0 to 9\n"
  str3:		.asciiz "The sum of your input array indices is\n"
.text
.globl main
main:
  # Ask for two indices
  # Make it friendly!! Print out a prompt so people know what to do! :)
  # // add your code //
  
  la a0, str1    # printString(str)
  li v0, 4
  syscall
  
  li v0, 5      # a = getInteger()
  syscall
  move s0, v0    #s0 is 1st int
  
  la a0, str2   # printString(str)
  li v0, 4
  syscall
  
  li v0, 5      # a = getInteger()
  syscall
  move s1, v0     #s1 is 2nd int

  
  la t0, myArray   #loads address of myArray into t0
  li t1, 4	#puts the s0'th element into t1
  mul t1, t1, s0	# t1 = t1 * 4 (multiplied by 4 bytes per item)
  add t1, t0, t1	# t2 = t0 + t1 ... that is: t2 = myArray + (2 * 4)
  lw s2, 0(t1)	# t0 = myArray[s0]
  
  la t0, myArray   #loads address of myArray into t0
  li t2, 4	#puts the s1'th element into t1
  mul t2, t2, s0	# t1 = t1 * 4 (multiplied by 4 bytes per item)
  add t2, t0, t2	# t2 = t0 + t1 ... that is: t2 = myArray + (2 * 4)
  lw s3, 0(t2)	# t0 = myArray[s0]
  
  add s4, s2, s3
  
  la a0, str3    # printString(str)
  li v0, 4
  syscall

  
  li v0, 1
  move a0, s4	#print sum of two indices
  syscall
  
  
  # Write your code here to retrieve each value from the array and sum them
  # // add your code //

  # Print the result
  # // add your code //

  # Exit the program with the exit syscall
  li  v0, 10
  syscall