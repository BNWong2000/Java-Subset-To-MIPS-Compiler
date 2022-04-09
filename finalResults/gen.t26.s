	.data
str0:	.byte 32, 61, 32, 10, 
	.align 2
str0Len:	.word 4
str1:	.byte 9, 
	.align 2
str1Len:	.word 1
str2:	.byte 32, 40, 98, 97, 115, 101, 32, 50, 41, 10, 
	.align 2
str2Len:	.word 10
str3:	.byte 9, 
	.align 2
str3Len:	.word 1
str4:	.byte 32, 40, 98, 97, 115, 101, 32, 56, 41, 10, 
	.align 2
str4Len:	.word 10
str5:	.byte 9, 
	.align 2
str5Len:	.word 1
str6:	.byte 32, 40, 98, 97, 115, 101, 32, 49, 48, 41, 10, 
	.align 2
str6Len:	.word 11

	.text
	.globl main

_convert:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # n
	sw $a0, 0($sp)
	subu $sp, $sp, 4    # base
	sw $a1, 0($sp)
	lw $t0, 4($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, ifEnd0

	li $a0, 0
	jal _printi
	
	lw $ra, 8($sp)
	addu $sp, $sp, 12
	jr $ra
	j ifEnd0
ifEnd0:
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	bnez $t1, goodDiv0
	.data
divZeroErr0:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck0:
	la $a0, divZeroErr0
	jal ERROR
goodDiv0:
	divu $t0, $t0, $t1

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	move $a0, $t0
	lw $a1, 4($sp)
	jal _convert
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	lw $t1, 4($sp)
	lw $t2, 0($sp)
	bnez $t2, goodDiv1
	.data
divZeroErr1:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck1:
	la $a0, divZeroErr1
	jal ERROR
goodDiv1:
	remu $t1, $t1, $t2

	subu $sp, $sp, 8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	move $a0, $t1
	jal _printi
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 8
	
	lw $ra, 8($sp)
	addu $sp, $sp, 12
	jr $ra

_do:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # i
	sw $a0, 0($sp)

	lw $a0, 0($sp)
	jal _printi

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	la $a0, str1
	lw $a1, str1Len
	jal _prints

	lw $a0, 0($sp)
	li $a1, 2
	jal _convert

	la $a0, str2
	lw $a1, str2Len
	jal _prints

	la $a0, str3
	lw $a1, str3Len
	jal _prints

	lw $a0, 0($sp)
	li $a1, 8
	jal _convert

	la $a0, str4
	lw $a1, str4Len
	jal _prints

	la $a0, str5
	lw $a1, str5Len
	jal _prints

	lw $a0, 0($sp)
	li $a1, 10
	jal _convert

	la $a0, str6
	lw $a1, str6Len
	jal _prints
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra
main:
	jal _main

_main:

	li $a0, 0
	jal _do

	li $a0, 17
	jal _do

	li $a0, 42
	jal _do
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
