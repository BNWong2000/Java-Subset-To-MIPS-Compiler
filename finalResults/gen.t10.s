	.data
str0:	.byte 102, 105, 98, 40, 
	.align 2
str0Len:	.word 4
str1:	.byte 41, 32, 61, 32, 
	.align 2
str1Len:	.word 4
str2:	.byte 10, 
	.align 2
str2Len:	.word 1

	.text
	.globl main
main:
	jal _main

_main:
	subu $sp, $sp, 4    # i
	li $t0, 0
	sw $t0, 0($sp)
whileStart0:
	lw $t0, 0($sp)
	li $t1, 46
	sle $t0, $t0, $t1
	beqz $t0, whileEnd0

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	lw $a0, 0($sp)
	jal _printi

	la $a0, str1
	lw $a1, str1Len
	jal _prints

	lw $a0, 0($sp)
	jal _fib
	move $t0, $v0

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	move $a0, $t0
	jal _printi
	lw $t0, 0($sp)
	addu $sp, $sp, 4

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	la $a0, str2
	lw $a1, str2Len
	jal _prints
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	lw $t1, 0($sp)
	li $t2, 1
	addu $t1, $t1, $t2
	sw $t1, 0($sp)
	j whileStart0
whileEnd0:
	li $v0, 10
	syscall

_fib:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # n
	sw $a0, 0($sp)
	lw $t1, 0($sp)
	li $t2, 0
	seq $t1, $t1, $t2
	beqz $t1, ifEnd0
	
	lw $ra, 4($sp)
	li $v0, 0
	addu $sp, $sp, 8
	jr $ra
	j ifEnd0
ifEnd0:
	lw $t1, 0($sp)
	li $t2, 1
	seq $t1, $t1, $t2
	beqz $t1, ifEnd1
	
	lw $ra, 4($sp)
	li $v0, 1
	addu $sp, $sp, 8
	jr $ra
	j ifEnd1
ifEnd1:
	lw $t1, 0($sp)
	li $t2, 1
	subu $t1, $t1, $t2

	subu $sp, $sp, 8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	move $a0, $t1
	jal _fib
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 8
	move $t2, $v0
	lw $t3, 0($sp)
	li $t4, 2
	subu $t3, $t3, $t4

	subu $sp, $sp, 16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	move $a0, $t3
	jal _fib
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 16
	move $t4, $v0
	addu $t2, $t2, $t4
	
	lw $ra, 4($sp)
	move $v0, $t2
	addu $sp, $sp, 8
	jr $ra
	.data
noRetErr1:	.asciiz "Runtime Error: No return from function fib
"
	.text
	la $a0, noRetErr1
	jal ERROR

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
