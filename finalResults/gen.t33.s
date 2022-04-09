	.data

	.text
	.globl main
main:
	jal _main

_main:
	subu $sp, $sp, 4    # i
whileStart0:

	jal _getchar
	move $t0, $v0
	sw $t0, 0($sp)
	li $t0, 1
	negu $t0, $t0
	lw $t1, 0($sp)
	sne $t1, $t1, $t0
	beqz $t1, whileEnd0

	lw $a0, 0($sp)
	jal _printc
	j whileStart0
whileEnd0:
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
