	.data
_i:	.word 0

	.text
	.globl main

_bar:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	li $t0, 12345
	sw $t0, _i
	
	lw $ra, 0($sp)
	addu $sp, $sp, 4
	jr $ra
main:
	jal _foo

_foo:

	jal _bar

	lw $a0, _i
	jal _printi
	subu $sp, $sp, 4    # i
	li $t0, 0
	sw $t0, 0($sp)

	lw $a0, 0($sp)
	jal _printb
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
