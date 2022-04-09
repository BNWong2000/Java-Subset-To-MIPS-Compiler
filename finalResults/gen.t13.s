	.data
_NL:	.word 0

	.text
	.globl main

_reverse:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # c

	jal _getchar
	move $t0, $v0
	sw $t0, 0($sp)
	lw $t0, 0($sp)
	lw $t1, _NL
	sne $t0, $t0, $t1
	beqz $t0, ifEnd0

	jal _reverse

	lw $a0, 0($sp)
	jal _printc
	j ifEnd0
ifEnd0:
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra
main:
	jal _main

_main:
	li $t0, 10
	sw $t0, _NL

	jal _reverse
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
