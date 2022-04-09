	.data
_d:	.word 0
str0:	.byte 10, 
	.align 2
str0Len:	.word 1

	.text
	.globl main

_foo:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # a
	sw $a0, 0($sp)
	subu $sp, $sp, 4    # b
	sw $a1, 0($sp)
	subu $sp, $sp, 4    # c
	sw $a2, 0($sp)
	subu $sp, $sp, 4    # d
	sw $a3, 0($sp)
	lw $t0, 12($sp)
	lw $t1, 8($sp)
	mul $t0, $t0, $t1
	lw $t1, 4($sp)
	mul $t0, $t0, $t1
	lw $t1, 0($sp)
	mul $t0, $t0, $t1
	
	lw $ra, 16($sp)
	move $v0, $t0
	addu $sp, $sp, 20
	jr $ra
	.data
noRetErr1:	.asciiz "Runtime Error: No return from function foo
"
	.text
	la $a0, noRetErr1
	jal ERROR

_bar:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # a
	sw $a0, 0($sp)
	subu $sp, $sp, 4    # b
	sw $a1, 0($sp)
	subu $sp, $sp, 4    # c
	sw $a2, 0($sp)
	lw $t0, _d
	li $t1, 3
	subu $t0, $t0, $t1

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	lw $a0, 12($sp)
	lw $a1, 8($sp)
	lw $a2, 4($sp)
	move $a3, $t0
	jal _foo
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	
	lw $ra, 12($sp)
	move $v0, $t1
	addu $sp, $sp, 16
	jr $ra
	.data
noRetErr2:	.asciiz "Runtime Error: No return from function bar
"
	.text
	la $a0, noRetErr2
	jal ERROR

_baz:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # a
	sw $a0, 0($sp)
	lw $t0, _d
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, _d
	
	lw $ra, 4($sp)
	lw $v0, 0($sp)
	addu $sp, $sp, 8
	jr $ra
	.data
noRetErr3:	.asciiz "Runtime Error: No return from function baz
"
	.text
	la $a0, noRetErr3
	jal ERROR
main:
	jal _mane

_mane:
	li $t0, 10
	sw $t0, _d

	li $a0, 3
	jal _baz
	move $t0, $v0

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	li $a0, 2
	move $a1, $t0
	li $a2, 4
	jal _bar
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0

	subu $sp, $sp, 8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	li $a0, 6
	jal _baz
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 8
	move $t2, $v0

	subu $sp, $sp, 12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	li $a0, 5
	move $a1, $t2
	li $a2, 7
	jal _bar
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 12
	move $t3, $v0

	subu $sp, $sp, 16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	li $a0, 8
	jal _baz
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 16
	move $t4, $v0

	subu $sp, $sp, 20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	li $a0, 1
	move $a1, $t1
	move $a2, $t3
	move $a3, $t4
	jal _foo
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 20
	move $t5, $v0

	subu $sp, $sp, 24
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	move $a0, $t5
	jal _printi
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 24

	subu $sp, $sp, 24
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	la $a0, str0
	lw $a1, str0Len
	jal _prints
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addu $sp, $sp, 24
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
