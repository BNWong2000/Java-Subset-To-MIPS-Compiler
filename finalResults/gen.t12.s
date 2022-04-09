	.data
str0:	.byte 102, 105, 98, 40, 48, 41, 32, 61, 32, 48, 10, 
	.align 2
str0Len:	.word 11
str1:	.byte 102, 105, 98, 40, 49, 41, 32, 61, 32, 49, 10, 
	.align 2
str1Len:	.word 11
str2:	.byte 102, 105, 98, 40, 
	.align 2
str2Len:	.word 4
str3:	.byte 41, 32, 61, 32, 
	.align 2
str3Len:	.word 4
str4:	.byte 10, 
	.align 2
str4Len:	.word 1

	.text
	.globl main
main:
	jal _main

_main:
	subu $sp, $sp, 4    # i
	subu $sp, $sp, 4    # n
	subu $sp, $sp, 4    # n_1
	subu $sp, $sp, 4    # n_2
	li $t0, 2
	sw $t0, 12($sp)
	li $t0, 1
	sw $t0, 4($sp)
	li $t0, 0
	sw $t0, 0($sp)

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	la $a0, str1
	lw $a1, str1Len
	jal _prints
whileStart0:
	lw $t0, 12($sp)
	li $t1, 47
	slt $t0, $t0, $t1
	beqz $t0, whileEnd0

	la $a0, str2
	lw $a1, str2Len
	jal _prints

	lw $a0, 12($sp)
	jal _printi

	la $a0, str3
	lw $a1, str3Len
	jal _prints
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addu $t0, $t0, $t1
	sw $t0, 8($sp)

	lw $a0, 8($sp)
	jal _printi
	lw $t0, 4($sp)
	sw $t0, 0($sp)
	lw $t0, 8($sp)
	sw $t0, 4($sp)

	la $a0, str4
	lw $a1, str4Len
	jal _prints
	lw $t0, 12($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 12($sp)
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
