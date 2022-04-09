	.data
_j:	.word 0
_i:	.word 0

	.text
	.globl main
main:
	jal _main

_main:
	li $t0, 12
	sw $t0, _j

	jal _foo
	lw $t0, _i
	li $t1, 2
	subu $t0, $t0, $t1
	lw $t1, _j
	bnez $t0, goodDiv0
	.data
divZeroErr0:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck0:
	la $a0, divZeroErr0
	jal ERROR
goodDiv0:
	divu $t1, $t1, $t0

	subu $sp, $sp, 4
	sw $t1, 0($sp)
	move $a0, $t1
	jal _printi
	lw $t1, 0($sp)
	addu $sp, $sp, 4
	li $v0, 10
	syscall

_foo:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	li $t0, 2
	sw $t0, _i
	
	lw $ra, 0($sp)
	addu $sp, $sp, 4
	jr $ra

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
