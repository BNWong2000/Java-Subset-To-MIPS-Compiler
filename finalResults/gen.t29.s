	.data
_a:	.word 0
_b:	.word 0
_c:	.word 0
str0:	.byte 101, 118, 97, 108, 117, 97, 116, 101, 100, 32, 65, 10, 
	.align 2
str0Len:	.word 12
str1:	.byte 101, 118, 97, 108, 117, 97, 116, 101, 100, 32, 66, 10, 
	.align 2
str1Len:	.word 12
str2:	.byte 101, 118, 97, 108, 117, 97, 116, 101, 100, 32, 67, 10, 
	.align 2
str2Len:	.word 12
str3:	.byte 105, 102, 32, 40, 40, 65, 32, 38, 38, 32, 66, 41, 32, 124, 124, 32, 67, 41, 32, 123, 46, 46, 46, 125, 32, 101, 108, 115, 101, 32, 123, 46, 46, 46, 125, 44, 32, 119, 105, 116, 104, 32, 65, 61, 
	.align 2
str3Len:	.word 44
str4:	.byte 32, 66, 61, 
	.align 2
str4Len:	.word 3
str5:	.byte 32, 67, 61, 
	.align 2
str5Len:	.word 3
str6:	.byte 10, 
	.align 2
str6Len:	.word 1
str7:	.byte 105, 102, 45, 112, 97, 114, 116, 32, 101, 120, 101, 99, 117, 116, 101, 100, 10, 
	.align 2
str7Len:	.word 17
str8:	.byte 101, 108, 115, 101, 45, 112, 97, 114, 116, 32, 101, 120, 101, 99, 117, 116, 101, 100, 10, 
	.align 2
str8Len:	.word 19
str9:	.byte 120, 32, 61, 32, 40, 65, 32, 38, 38, 32, 33, 66, 41, 32, 124, 124, 32, 67, 44, 32, 119, 105, 116, 104, 32, 65, 61, 
	.align 2
str9Len:	.word 27
str10:	.byte 32, 66, 61, 
	.align 2
str10Len:	.word 3
str11:	.byte 32, 67, 61, 
	.align 2
str11Len:	.word 3
str12:	.byte 10, 
	.align 2
str12Len:	.word 1
str13:	.byte 120, 61, 
	.align 2
str13Len:	.word 2
str14:	.byte 10, 
	.align 2
str14Len:	.word 1
str15:	.byte 10, 
	.align 2
str15Len:	.word 1
str16:	.byte 10, 
	.align 2
str16Len:	.word 1
str17:	.byte 10, 
	.align 2
str17Len:	.word 1
str18:	.byte 10, 
	.align 2
str18Len:	.word 1
str19:	.byte 10, 
	.align 2
str19Len:	.word 1
str20:	.byte 10, 
	.align 2
str20Len:	.word 1
str21:	.byte 10, 
	.align 2
str21Len:	.word 1
str22:	.byte 10, 
	.align 2
str22Len:	.word 1
str23:	.byte 10, 
	.align 2
str23Len:	.word 1
str24:	.byte 10, 
	.align 2
str24Len:	.word 1
str25:	.byte 10, 
	.align 2
str25Len:	.word 1
str26:	.byte 10, 
	.align 2
str26Len:	.word 1
str27:	.byte 10, 
	.align 2
str27Len:	.word 1
str28:	.byte 10, 
	.align 2
str28Len:	.word 1
str29:	.byte 10, 
	.align 2
str29Len:	.word 1

	.text
	.globl main

_A:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, str0
	lw $a1, str0Len
	jal _prints
	
	lw $ra, 0($sp)
	lw $v0, _a
	addu $sp, $sp, 4
	jr $ra
	.data
noRetErr1:	.asciiz "Runtime Error: No return from function A
"
	.text
	la $a0, noRetErr1
	jal ERROR

_B:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, str1
	lw $a1, str1Len
	jal _prints
	
	lw $ra, 0($sp)
	lw $v0, _b
	addu $sp, $sp, 4
	jr $ra
	.data
noRetErr2:	.asciiz "Runtime Error: No return from function B
"
	.text
	la $a0, noRetErr2
	jal ERROR

_C:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, str2
	lw $a1, str2Len
	jal _prints
	
	lw $ra, 0($sp)
	lw $v0, _c
	addu $sp, $sp, 4
	jr $ra
	.data
noRetErr3:	.asciiz "Runtime Error: No return from function C
"
	.text
	la $a0, noRetErr3
	jal ERROR

_eval:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # newa
	sw $a0, 0($sp)
	subu $sp, $sp, 4    # n00b
	sw $a1, 0($sp)
	subu $sp, $sp, 4    # newc
	sw $a2, 0($sp)
	lw $t0, 8($sp)
	sw $t0, _a
	lw $t0, 4($sp)
	sw $t0, _b
	lw $t0, 0($sp)
	sw $t0, _c

	la $a0, str3
	lw $a1, str3Len
	jal _prints

	lw $a0, _a
	jal _printb

	la $a0, str4
	lw $a1, str4Len
	jal _prints

	lw $a0, _b
	jal _printb

	la $a0, str5
	lw $a1, str5Len
	jal _prints

	lw $a0, _c
	jal _printb

	la $a0, str6
	lw $a1, str6Len
	jal _prints

	jal _A
	move $t0, $v0
	beqz $t0, cond1

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _B
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	and $t0, $t0, $t1
cond1:
	bnez $t0, cond0

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _C
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	or $t0, $t0, $t1
cond0:
	beqz $t0, elseStart0

	la $a0, str7
	lw $a1, str7Len
	jal _prints
	j ifEnd0
elseStart0:

	la $a0, str8
	lw $a1, str8Len
	jal _prints
ifEnd0:
	
	lw $ra, 12($sp)
	addu $sp, $sp, 16
	jr $ra

_assign:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # newa
	sw $a0, 0($sp)
	subu $sp, $sp, 4    # newb
	sw $a1, 0($sp)
	subu $sp, $sp, 4    # newc
	sw $a2, 0($sp)
	lw $t0, 8($sp)
	sw $t0, _a
	lw $t0, 4($sp)
	sw $t0, _b
	lw $t0, 0($sp)
	sw $t0, _c

	la $a0, str9
	lw $a1, str9Len
	jal _prints

	lw $a0, _a
	jal _printb

	la $a0, str10
	lw $a1, str10Len
	jal _prints

	lw $a0, _b
	jal _printb

	la $a0, str11
	lw $a1, str11Len
	jal _prints

	lw $a0, _c
	jal _printb

	la $a0, str12
	lw $a1, str12Len
	jal _prints
	subu $sp, $sp, 4    # x

	jal _A
	move $t0, $v0
	beqz $t0, cond3

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _B
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	xori $t1, $t1, 1
	and $t0, $t0, $t1
cond3:
	bnez $t0, cond2

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _C
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	or $t0, $t0, $t1
cond2:
	sw $t0, 0($sp)

	la $a0, str13
	lw $a1, str13Len
	jal _prints

	lw $a0, 0($sp)
	jal _printb

	la $a0, str14
	lw $a1, str14Len
	jal _prints
	
	lw $ra, 16($sp)
	addu $sp, $sp, 20
	jr $ra
main:
	jal _main

_main:

	li $a0, 0
	li $a1, 0
	li $a2, 0
	jal _eval

	la $a0, str15
	lw $a1, str15Len
	jal _prints

	li $a0, 0
	li $a1, 0
	li $a2, 1
	jal _eval

	la $a0, str16
	lw $a1, str16Len
	jal _prints

	li $a0, 0
	li $a1, 1
	li $a2, 0
	jal _eval

	la $a0, str17
	lw $a1, str17Len
	jal _prints

	li $a0, 0
	li $a1, 1
	li $a2, 1
	jal _eval

	la $a0, str18
	lw $a1, str18Len
	jal _prints

	li $a0, 1
	li $a1, 0
	li $a2, 0
	jal _eval

	la $a0, str19
	lw $a1, str19Len
	jal _prints

	li $a0, 1
	li $a1, 0
	li $a2, 1
	jal _eval

	la $a0, str20
	lw $a1, str20Len
	jal _prints

	li $a0, 1
	li $a1, 1
	li $a2, 0
	jal _eval

	la $a0, str21
	lw $a1, str21Len
	jal _prints

	li $a0, 1
	li $a1, 1
	li $a2, 1
	jal _eval

	la $a0, str22
	lw $a1, str22Len
	jal _prints

	li $a0, 0
	li $a1, 0
	li $a2, 0
	jal _assign

	la $a0, str23
	lw $a1, str23Len
	jal _prints

	li $a0, 0
	li $a1, 0
	li $a2, 1
	jal _assign

	la $a0, str24
	lw $a1, str24Len
	jal _prints

	li $a0, 0
	li $a1, 1
	li $a2, 0
	jal _assign

	la $a0, str25
	lw $a1, str25Len
	jal _prints

	li $a0, 0
	li $a1, 1
	li $a2, 1
	jal _assign

	la $a0, str26
	lw $a1, str26Len
	jal _prints

	li $a0, 1
	li $a1, 0
	li $a2, 0
	jal _assign

	la $a0, str27
	lw $a1, str27Len
	jal _prints

	li $a0, 1
	li $a1, 0
	li $a2, 1
	jal _assign

	la $a0, str28
	lw $a1, str28Len
	jal _prints

	li $a0, 1
	li $a1, 1
	li $a2, 0
	jal _assign

	la $a0, str29
	lw $a1, str29Len
	jal _prints

	li $a0, 1
	li $a1, 1
	li $a2, 1
	jal _assign
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
