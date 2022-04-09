	.data
_i:	.word 0
_k:	.word 0

	.text
	.globl main
main:
	jal _main

_main:
	subu $sp, $sp, 4    # j
	li $t0, 123
	sw $t0, _i
	li $t0, 456
	sw $t0, 0($sp)
	li $t0, 789
	sw $t0, _k
	li $t0, 42
	sw $t0, _k
	lw $t0, _k
	sw $t0, 0($sp)
	lw $t0, 0($sp)
	sw $t0, _i
	subu $sp, $sp, 4    # NL
	li $t0, 10
	sw $t0, 0($sp)

	lw $a0, _i
	jal _printi

	lw $a0, 0($sp)
	jal _printc

	lw $a0, 4($sp)
	jal _printi

	lw $a0, 0($sp)
	jal _printc

	lw $a0, _k
	jal _printi

	lw $a0, 0($sp)
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
