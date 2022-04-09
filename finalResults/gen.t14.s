	.data
str0:	.byte 109, 105, 110, 105, 110, 116, 32, 105, 115, 32, 
	.align 2
str0Len:	.word 10
str1:	.byte 10, 
	.align 2
str1Len:	.word 1

	.text
	.globl main
main:
	jal _main

_main:
	subu $sp, $sp, 4    # i
	subu $sp, $sp, 4    # delta
	li $t0, 0
	sw $t0, 4($sp)
	li $t0, 1000000
	sw $t0, 0($sp)
whileStart0:
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	subu $t0, $t0, $t1
	lw $t1, 4($sp)
	sgt $t1, $t1, $t0
	beqz $t1, whileEnd0
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addu $t0, $t0, $t1
	sw $t0, 4($sp)
	j whileStart0
whileEnd0:
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	subu $t0, $t0, $t1
	sw $t0, 4($sp)
whileStart1:
	lw $t0, 4($sp)
	li $t1, 1
	subu $t0, $t0, $t1
	lw $t1, 4($sp)
	sgt $t1, $t1, $t0
	beqz $t1, whileEnd1
	lw $t0, 4($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 4($sp)
	j whileStart1
whileEnd1:

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	lw $a0, 4($sp)
	jal _printi

	la $a0, str1
	lw $a1, str1Len
	jal _prints
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
