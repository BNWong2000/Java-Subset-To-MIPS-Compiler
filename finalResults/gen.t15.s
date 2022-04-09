	.data
str0:	.byte 10, 
	.align 2
str0Len:	.word 1

	.text
	.globl main

_nl:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, str0
	lw $a1, str0Len
	jal _prints
	
	lw $ra, 0($sp)
	addu $sp, $sp, 4
	jr $ra
main:
	jal _main

_main:
	li $t0, 123
	negu $t0, $t0

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	move $a0, $t0
	jal _printi
	lw $t0, 0($sp)
	addu $sp, $sp, 4

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _nl
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	li $t1, -2147483648
	negu $t1, $t1

	subu $sp, $sp, 8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	move $a0, $t1
	jal _printi
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 8

	subu $sp, $sp, 8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	jal _nl
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 8
	li $t2, -2147483648
	negu $t2, $t2
	negu $t2, $t2

	subu $sp, $sp, 12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	move $a0, $t2
	jal _printi
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 12

	subu $sp, $sp, 12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	jal _nl
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 12
	li $t3, -2147483648
	negu $t3, $t3
	negu $t3, $t3
	negu $t3, $t3

	subu $sp, $sp, 16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	move $a0, $t3
	jal _printi
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 16

	subu $sp, $sp, 16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	jal _nl
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 16
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
