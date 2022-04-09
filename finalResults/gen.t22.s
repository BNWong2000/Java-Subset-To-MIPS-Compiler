	.data
str0:	.byte 97, 115, 100, 102, 
	.align 2
str0Len:	.word 4
str1:	.byte 8, 9, 10, 12, 13, 34, 39, , 92, 
	.align 2
str1Len:	.word 9
str2:	.byte 1, 26, 
	.align 2
str2Len:	.word 2
str3:	.byte 0, 32, 97, 115, 100, 102, 
	.align 2
str3Len:	.word 6

	.text
	.globl main
main:
	jal _foo

_foo:

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	la $a0, str1
	lw $a1, str1Len
	jal _prints

	la $a0, str2
	lw $a1, str2Len
	jal _prints
	li $t0, 1
	beqz $t0, ifEnd0

	la $a0, str3
	lw $a1, str3Len
	jal _prints
	j ifEnd0
ifEnd0:

	li $a0, 0
	jal _printc
	li $v0, 10
	syscall

_getchar:
	li $v0, 12 
	syscall 
	jr $ra

_halt:
	li $v0, 10 
	syscall 
	jr $ra

_printb:
	li $v0, 1 
	syscall 
	jr $ra

_printc:
	li $v0, 11 
	syscall 
	jr $ra

_printi:
	li $v0, 1 
	syscall 
	jr $ra

_prints:
	li $s0, 0        # store 0 in $s0
	move $s1, $a0
W1:            # Loop start
 	beq $s0, $a1, EW1
	addu $t1, $s1, $s0
	lbu $a0, ($t1)
	li $v0, 11
	syscall
	addiu $s0, $s0, 1
	j W1
EW1:
	jr $ra

ERROR:
	li $v0, 4    # print error message ascii
	syscall 
	li $v0, 10   # halt
	syscall 
	jr $ra
