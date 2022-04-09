	.data
_i1:	.word 0
_b1:	.word 0
str0:	.byte 10, 40, 105, 116, 39, 115, 32, 111, 107, 32, 105, 102, 32, 116, 104, 101, 32, 102, 111, 108, 108, 111, 119, 105, 110, 103, 32, 97, 114, 101, 110, 39, 116, 32, 48, 47, 102, 97, 108, 115, 101, 41, 10, 
	.align 2
str0Len:	.word 43
str1:	.byte 9, 108, 111, 99, 97, 108, 32, 105, 110, 116, 32, 100, 101, 102, 97, 117, 108, 116, 32, 118, 97, 108, 117, 101, 58, 32, 
	.align 2
str1Len:	.word 26
str2:	.byte 10, 
	.align 2
str2Len:	.word 1
str3:	.byte 9, 108, 111, 99, 97, 108, 32, 98, 111, 111, 108, 101, 97, 110, 32, 100, 101, 102, 97, 117, 108, 116, 32, 118, 97, 108, 117, 101, 58, 32, 
	.align 2
str3Len:	.word 30
str4:	.byte 10, 
	.align 2
str4Len:	.word 1
str5:	.byte 103, 108, 111, 98, 97, 108, 32, 105, 110, 116, 32, 100, 101, 102, 97, 117, 108, 116, 32, 118, 97, 108, 117, 101, 58, 32, 
	.align 2
str5Len:	.word 26
str6:	.byte 10, 
	.align 2
str6Len:	.word 1
str7:	.byte 103, 108, 111, 98, 97, 108, 32, 98, 111, 111, 108, 101, 97, 110, 32, 100, 101, 102, 97, 117, 108, 116, 32, 118, 97, 108, 117, 101, 58, 32, 
	.align 2
str7Len:	.word 30
str8:	.byte 10, 
	.align 2
str8Len:	.word 1

	.text
	.globl main

_foo:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # i2
	subu $sp, $sp, 4    # b2

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	la $a0, str1
	lw $a1, str1Len
	jal _prints

	lw $a0, 4($sp)
	jal _printi

	la $a0, str2
	lw $a1, str2Len
	jal _prints

	la $a0, str3
	lw $a1, str3Len
	jal _prints

	lw $a0, 0($sp)
	jal _printb

	la $a0, str4
	lw $a1, str4Len
	jal _prints
	li $t0, 123
	sw $t0, 4($sp)
	li $t0, 1
	sw $t0, 0($sp)
	
	lw $ra, 8($sp)
	addu $sp, $sp, 12
	jr $ra
main:
	jal _main

_main:

	la $a0, str5
	lw $a1, str5Len
	jal _prints

	lw $a0, _i1
	jal _printi

	la $a0, str6
	lw $a1, str6Len
	jal _prints

	la $a0, str7
	lw $a1, str7Len
	jal _prints

	lw $a0, _b1
	jal _printb

	la $a0, str8
	lw $a1, str8Len
	jal _prints

	jal _foo

	jal _foo
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
