	.data
_A_0:	.word 0
_A_1:	.word 0
_A_2:	.word 0
_A_3:	.word 0
_A_4:	.word 0
_A_5:	.word 0
_A_6:	.word 0
_A_7:	.word 0
_A_8:	.word 0
_A_9:	.word 0
_A_10:	.word 0
_A_11:	.word 0
_A_12:	.word 0
_A_13:	.word 0
_A_14:	.word 0
_not_there:	.word 0
str0:	.byte 32, 
	.align 2
str0Len:	.word 1
str1:	.byte 32, 
	.align 2
str1Len:	.word 1
str2:	.byte 32, 
	.align 2
str2Len:	.word 1
str3:	.byte 32, 
	.align 2
str3Len:	.word 1
str4:	.byte 32, 
	.align 2
str4Len:	.word 1
str5:	.byte 32, 
	.align 2
str5Len:	.word 1
str6:	.byte 32, 
	.align 2
str6Len:	.word 1
str7:	.byte 32, 
	.align 2
str7Len:	.word 1
str8:	.byte 32, 
	.align 2
str8Len:	.word 1
str9:	.byte 32, 
	.align 2
str9Len:	.word 1
str10:	.byte 32, 
	.align 2
str10Len:	.word 1
str11:	.byte 32, 
	.align 2
str11Len:	.word 1
str12:	.byte 32, 
	.align 2
str12Len:	.word 1
str13:	.byte 32, 
	.align 2
str13Len:	.word 1
str14:	.byte 32, 
	.align 2
str14Len:	.word 1
str15:	.byte 10, 
	.align 2
str15Len:	.word 1
_INTERNALX:	.word 0

	.text
	.globl main
main:
	jal _main

_main:
	subu $sp, $sp, 4    # i
	subu $sp, $sp, 4    # j
	subu $sp, $sp, 4    # t
	subu $sp, $sp, 4    # min

	li $a0, 1
	jal _INTERNALseed
	li $t0, 0
	sw $t0, 12($sp)
whileStart0:
	lw $t0, 12($sp)
	li $t1, 14
	sle $t0, $t0, $t1
	beqz $t0, whileEnd0
	lw $t0, 12($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart0

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv0
	.data
divZeroErr0:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck0:
	la $a0, divZeroErr0
	jal ERROR
goodDiv0:
	remu $t0, $t0, $t1
	sw $t0, _A_0
	j ifEnd0
elseStart0:
	lw $t0, 12($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart1

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv1
	.data
divZeroErr1:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck1:
	la $a0, divZeroErr1
	jal ERROR
goodDiv1:
	remu $t0, $t0, $t1
	sw $t0, _A_1
	j ifEnd1
elseStart1:
	lw $t0, 12($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart2

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv2
	.data
divZeroErr2:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck2:
	la $a0, divZeroErr2
	jal ERROR
goodDiv2:
	remu $t0, $t0, $t1
	sw $t0, _A_2
	j ifEnd2
elseStart2:
	lw $t0, 12($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart3

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv3
	.data
divZeroErr3:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck3:
	la $a0, divZeroErr3
	jal ERROR
goodDiv3:
	remu $t0, $t0, $t1
	sw $t0, _A_3
	j ifEnd3
elseStart3:
	lw $t0, 12($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart4

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv4
	.data
divZeroErr4:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck4:
	la $a0, divZeroErr4
	jal ERROR
goodDiv4:
	remu $t0, $t0, $t1
	sw $t0, _A_4
	j ifEnd4
elseStart4:
	lw $t0, 12($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart5

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv5
	.data
divZeroErr5:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck5:
	la $a0, divZeroErr5
	jal ERROR
goodDiv5:
	remu $t0, $t0, $t1
	sw $t0, _A_5
	j ifEnd5
elseStart5:
	lw $t0, 12($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart6

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv6
	.data
divZeroErr6:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck6:
	la $a0, divZeroErr6
	jal ERROR
goodDiv6:
	remu $t0, $t0, $t1
	sw $t0, _A_6
	j ifEnd6
elseStart6:
	lw $t0, 12($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart7

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv7
	.data
divZeroErr7:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck7:
	la $a0, divZeroErr7
	jal ERROR
goodDiv7:
	remu $t0, $t0, $t1
	sw $t0, _A_7
	j ifEnd7
elseStart7:
	lw $t0, 12($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart8

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv8
	.data
divZeroErr8:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck8:
	la $a0, divZeroErr8
	jal ERROR
goodDiv8:
	remu $t0, $t0, $t1
	sw $t0, _A_8
	j ifEnd8
elseStart8:
	lw $t0, 12($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart9

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv9
	.data
divZeroErr9:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck9:
	la $a0, divZeroErr9
	jal ERROR
goodDiv9:
	remu $t0, $t0, $t1
	sw $t0, _A_9
	j ifEnd9
elseStart9:
	lw $t0, 12($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart10

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv10
	.data
divZeroErr10:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck10:
	la $a0, divZeroErr10
	jal ERROR
goodDiv10:
	remu $t0, $t0, $t1
	sw $t0, _A_10
	j ifEnd10
elseStart10:
	lw $t0, 12($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart11

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv11
	.data
divZeroErr11:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck11:
	la $a0, divZeroErr11
	jal ERROR
goodDiv11:
	remu $t0, $t0, $t1
	sw $t0, _A_11
	j ifEnd11
elseStart11:
	lw $t0, 12($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart12

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv12
	.data
divZeroErr12:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck12:
	la $a0, divZeroErr12
	jal ERROR
goodDiv12:
	remu $t0, $t0, $t1
	sw $t0, _A_12
	j ifEnd12
elseStart12:
	lw $t0, 12($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart13

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv13
	.data
divZeroErr13:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck13:
	la $a0, divZeroErr13
	jal ERROR
goodDiv13:
	remu $t0, $t0, $t1
	sw $t0, _A_13
	j ifEnd13
elseStart13:
	lw $t0, 12($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd14

	jal _INTERNALrandom
	move $t0, $v0
	li $t1, 100
	bnez $t1, goodDiv14
	.data
divZeroErr14:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck14:
	la $a0, divZeroErr14
	jal ERROR
goodDiv14:
	remu $t0, $t0, $t1
	sw $t0, _A_14
	j ifEnd14
ifEnd14:
ifEnd13:
ifEnd12:
ifEnd11:
ifEnd10:
ifEnd9:
ifEnd8:
ifEnd7:
ifEnd6:
ifEnd5:
ifEnd4:
ifEnd3:
ifEnd2:
ifEnd1:
ifEnd0:
	lw $t0, 12($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 12($sp)
	j whileStart0
whileEnd0:

	jal _printarray
	li $t0, 0
	sw $t0, 12($sp)
whileStart1:
	lw $t0, 12($sp)
	li $t1, 13
	sle $t0, $t0, $t1
	beqz $t0, whileEnd1
	lw $t0, 12($sp)
	sw $t0, 0($sp)
	lw $t0, 12($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 8($sp)
whileStart2:
	lw $t0, 8($sp)
	li $t1, 14
	sle $t0, $t0, $t1
	beqz $t0, whileEnd2
	lw $t0, 8($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart15
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart16
	lw $t0, _A_1
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd17
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd17
ifEnd17:
	j ifEnd16
elseStart16:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart18
	lw $t0, _A_1
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd19
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd19
ifEnd19:
	j ifEnd18
elseStart18:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart20
	lw $t0, _A_1
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd21
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd21
ifEnd21:
	j ifEnd20
elseStart20:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart22
	lw $t0, _A_1
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd23
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd23
ifEnd23:
	j ifEnd22
elseStart22:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart24
	lw $t0, _A_1
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd25
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd25
ifEnd25:
	j ifEnd24
elseStart24:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart26
	lw $t0, _A_1
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd27
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd27
ifEnd27:
	j ifEnd26
elseStart26:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart28
	lw $t0, _A_1
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd29
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd29
ifEnd29:
	j ifEnd28
elseStart28:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart30
	lw $t0, _A_1
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd31
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd31
ifEnd31:
	j ifEnd30
elseStart30:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart32
	lw $t0, _A_1
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd33
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd33
ifEnd33:
	j ifEnd32
elseStart32:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart34
	lw $t0, _A_1
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd35
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd35
ifEnd35:
	j ifEnd34
elseStart34:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart36
	lw $t0, _A_1
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd37
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd37
ifEnd37:
	j ifEnd36
elseStart36:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart38
	lw $t0, _A_1
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd39
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd39
ifEnd39:
	j ifEnd38
elseStart38:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart40
	lw $t0, _A_1
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd41
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd41
ifEnd41:
	j ifEnd40
elseStart40:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart42
	lw $t0, _A_1
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd43
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd43
ifEnd43:
	j ifEnd42
elseStart42:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd44
	lw $t0, _A_1
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd45
	li $t0, 1
	sw $t0, 0($sp)
	j ifEnd45
ifEnd45:
	j ifEnd44
ifEnd44:
ifEnd42:
ifEnd40:
ifEnd38:
ifEnd36:
ifEnd34:
ifEnd32:
ifEnd30:
ifEnd28:
ifEnd26:
ifEnd24:
ifEnd22:
ifEnd20:
ifEnd18:
ifEnd16:
	j ifEnd15
elseStart15:
	lw $t0, 8($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart46
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart47
	lw $t0, _A_2
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd48
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd48
ifEnd48:
	j ifEnd47
elseStart47:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart49
	lw $t0, _A_2
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd50
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd50
ifEnd50:
	j ifEnd49
elseStart49:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart51
	lw $t0, _A_2
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd52
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd52
ifEnd52:
	j ifEnd51
elseStart51:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart53
	lw $t0, _A_2
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd54
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd54
ifEnd54:
	j ifEnd53
elseStart53:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart55
	lw $t0, _A_2
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd56
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd56
ifEnd56:
	j ifEnd55
elseStart55:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart57
	lw $t0, _A_2
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd58
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd58
ifEnd58:
	j ifEnd57
elseStart57:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart59
	lw $t0, _A_2
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd60
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd60
ifEnd60:
	j ifEnd59
elseStart59:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart61
	lw $t0, _A_2
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd62
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd62
ifEnd62:
	j ifEnd61
elseStart61:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart63
	lw $t0, _A_2
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd64
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd64
ifEnd64:
	j ifEnd63
elseStart63:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart65
	lw $t0, _A_2
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd66
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd66
ifEnd66:
	j ifEnd65
elseStart65:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart67
	lw $t0, _A_2
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd68
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd68
ifEnd68:
	j ifEnd67
elseStart67:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart69
	lw $t0, _A_2
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd70
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd70
ifEnd70:
	j ifEnd69
elseStart69:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart71
	lw $t0, _A_2
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd72
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd72
ifEnd72:
	j ifEnd71
elseStart71:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart73
	lw $t0, _A_2
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd74
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd74
ifEnd74:
	j ifEnd73
elseStart73:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd75
	lw $t0, _A_2
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd76
	li $t0, 2
	sw $t0, 0($sp)
	j ifEnd76
ifEnd76:
	j ifEnd75
ifEnd75:
ifEnd73:
ifEnd71:
ifEnd69:
ifEnd67:
ifEnd65:
ifEnd63:
ifEnd61:
ifEnd59:
ifEnd57:
ifEnd55:
ifEnd53:
ifEnd51:
ifEnd49:
ifEnd47:
	j ifEnd46
elseStart46:
	lw $t0, 8($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart77
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart78
	lw $t0, _A_3
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd79
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd79
ifEnd79:
	j ifEnd78
elseStart78:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart80
	lw $t0, _A_3
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd81
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd81
ifEnd81:
	j ifEnd80
elseStart80:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart82
	lw $t0, _A_3
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd83
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd83
ifEnd83:
	j ifEnd82
elseStart82:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart84
	lw $t0, _A_3
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd85
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd85
ifEnd85:
	j ifEnd84
elseStart84:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart86
	lw $t0, _A_3
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd87
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd87
ifEnd87:
	j ifEnd86
elseStart86:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart88
	lw $t0, _A_3
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd89
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd89
ifEnd89:
	j ifEnd88
elseStart88:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart90
	lw $t0, _A_3
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd91
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd91
ifEnd91:
	j ifEnd90
elseStart90:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart92
	lw $t0, _A_3
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd93
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd93
ifEnd93:
	j ifEnd92
elseStart92:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart94
	lw $t0, _A_3
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd95
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd95
ifEnd95:
	j ifEnd94
elseStart94:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart96
	lw $t0, _A_3
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd97
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd97
ifEnd97:
	j ifEnd96
elseStart96:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart98
	lw $t0, _A_3
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd99
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd99
ifEnd99:
	j ifEnd98
elseStart98:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart100
	lw $t0, _A_3
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd101
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd101
ifEnd101:
	j ifEnd100
elseStart100:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart102
	lw $t0, _A_3
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd103
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd103
ifEnd103:
	j ifEnd102
elseStart102:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart104
	lw $t0, _A_3
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd105
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd105
ifEnd105:
	j ifEnd104
elseStart104:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd106
	lw $t0, _A_3
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd107
	li $t0, 3
	sw $t0, 0($sp)
	j ifEnd107
ifEnd107:
	j ifEnd106
ifEnd106:
ifEnd104:
ifEnd102:
ifEnd100:
ifEnd98:
ifEnd96:
ifEnd94:
ifEnd92:
ifEnd90:
ifEnd88:
ifEnd86:
ifEnd84:
ifEnd82:
ifEnd80:
ifEnd78:
	j ifEnd77
elseStart77:
	lw $t0, 8($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart108
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart109
	lw $t0, _A_4
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd110
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd110
ifEnd110:
	j ifEnd109
elseStart109:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart111
	lw $t0, _A_4
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd112
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd112
ifEnd112:
	j ifEnd111
elseStart111:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart113
	lw $t0, _A_4
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd114
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd114
ifEnd114:
	j ifEnd113
elseStart113:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart115
	lw $t0, _A_4
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd116
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd116
ifEnd116:
	j ifEnd115
elseStart115:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart117
	lw $t0, _A_4
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd118
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd118
ifEnd118:
	j ifEnd117
elseStart117:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart119
	lw $t0, _A_4
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd120
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd120
ifEnd120:
	j ifEnd119
elseStart119:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart121
	lw $t0, _A_4
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd122
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd122
ifEnd122:
	j ifEnd121
elseStart121:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart123
	lw $t0, _A_4
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd124
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd124
ifEnd124:
	j ifEnd123
elseStart123:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart125
	lw $t0, _A_4
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd126
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd126
ifEnd126:
	j ifEnd125
elseStart125:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart127
	lw $t0, _A_4
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd128
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd128
ifEnd128:
	j ifEnd127
elseStart127:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart129
	lw $t0, _A_4
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd130
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd130
ifEnd130:
	j ifEnd129
elseStart129:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart131
	lw $t0, _A_4
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd132
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd132
ifEnd132:
	j ifEnd131
elseStart131:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart133
	lw $t0, _A_4
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd134
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd134
ifEnd134:
	j ifEnd133
elseStart133:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart135
	lw $t0, _A_4
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd136
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd136
ifEnd136:
	j ifEnd135
elseStart135:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd137
	lw $t0, _A_4
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd138
	li $t0, 4
	sw $t0, 0($sp)
	j ifEnd138
ifEnd138:
	j ifEnd137
ifEnd137:
ifEnd135:
ifEnd133:
ifEnd131:
ifEnd129:
ifEnd127:
ifEnd125:
ifEnd123:
ifEnd121:
ifEnd119:
ifEnd117:
ifEnd115:
ifEnd113:
ifEnd111:
ifEnd109:
	j ifEnd108
elseStart108:
	lw $t0, 8($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart139
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart140
	lw $t0, _A_5
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd141
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd141
ifEnd141:
	j ifEnd140
elseStart140:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart142
	lw $t0, _A_5
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd143
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd143
ifEnd143:
	j ifEnd142
elseStart142:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart144
	lw $t0, _A_5
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd145
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd145
ifEnd145:
	j ifEnd144
elseStart144:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart146
	lw $t0, _A_5
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd147
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd147
ifEnd147:
	j ifEnd146
elseStart146:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart148
	lw $t0, _A_5
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd149
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd149
ifEnd149:
	j ifEnd148
elseStart148:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart150
	lw $t0, _A_5
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd151
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd151
ifEnd151:
	j ifEnd150
elseStart150:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart152
	lw $t0, _A_5
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd153
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd153
ifEnd153:
	j ifEnd152
elseStart152:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart154
	lw $t0, _A_5
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd155
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd155
ifEnd155:
	j ifEnd154
elseStart154:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart156
	lw $t0, _A_5
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd157
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd157
ifEnd157:
	j ifEnd156
elseStart156:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart158
	lw $t0, _A_5
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd159
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd159
ifEnd159:
	j ifEnd158
elseStart158:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart160
	lw $t0, _A_5
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd161
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd161
ifEnd161:
	j ifEnd160
elseStart160:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart162
	lw $t0, _A_5
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd163
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd163
ifEnd163:
	j ifEnd162
elseStart162:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart164
	lw $t0, _A_5
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd165
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd165
ifEnd165:
	j ifEnd164
elseStart164:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart166
	lw $t0, _A_5
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd167
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd167
ifEnd167:
	j ifEnd166
elseStart166:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd168
	lw $t0, _A_5
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd169
	li $t0, 5
	sw $t0, 0($sp)
	j ifEnd169
ifEnd169:
	j ifEnd168
ifEnd168:
ifEnd166:
ifEnd164:
ifEnd162:
ifEnd160:
ifEnd158:
ifEnd156:
ifEnd154:
ifEnd152:
ifEnd150:
ifEnd148:
ifEnd146:
ifEnd144:
ifEnd142:
ifEnd140:
	j ifEnd139
elseStart139:
	lw $t0, 8($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart170
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart171
	lw $t0, _A_6
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd172
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd172
ifEnd172:
	j ifEnd171
elseStart171:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart173
	lw $t0, _A_6
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd174
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd174
ifEnd174:
	j ifEnd173
elseStart173:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart175
	lw $t0, _A_6
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd176
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd176
ifEnd176:
	j ifEnd175
elseStart175:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart177
	lw $t0, _A_6
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd178
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd178
ifEnd178:
	j ifEnd177
elseStart177:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart179
	lw $t0, _A_6
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd180
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd180
ifEnd180:
	j ifEnd179
elseStart179:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart181
	lw $t0, _A_6
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd182
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd182
ifEnd182:
	j ifEnd181
elseStart181:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart183
	lw $t0, _A_6
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd184
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd184
ifEnd184:
	j ifEnd183
elseStart183:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart185
	lw $t0, _A_6
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd186
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd186
ifEnd186:
	j ifEnd185
elseStart185:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart187
	lw $t0, _A_6
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd188
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd188
ifEnd188:
	j ifEnd187
elseStart187:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart189
	lw $t0, _A_6
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd190
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd190
ifEnd190:
	j ifEnd189
elseStart189:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart191
	lw $t0, _A_6
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd192
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd192
ifEnd192:
	j ifEnd191
elseStart191:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart193
	lw $t0, _A_6
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd194
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd194
ifEnd194:
	j ifEnd193
elseStart193:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart195
	lw $t0, _A_6
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd196
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd196
ifEnd196:
	j ifEnd195
elseStart195:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart197
	lw $t0, _A_6
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd198
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd198
ifEnd198:
	j ifEnd197
elseStart197:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd199
	lw $t0, _A_6
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd200
	li $t0, 6
	sw $t0, 0($sp)
	j ifEnd200
ifEnd200:
	j ifEnd199
ifEnd199:
ifEnd197:
ifEnd195:
ifEnd193:
ifEnd191:
ifEnd189:
ifEnd187:
ifEnd185:
ifEnd183:
ifEnd181:
ifEnd179:
ifEnd177:
ifEnd175:
ifEnd173:
ifEnd171:
	j ifEnd170
elseStart170:
	lw $t0, 8($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart201
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart202
	lw $t0, _A_7
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd203
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd203
ifEnd203:
	j ifEnd202
elseStart202:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart204
	lw $t0, _A_7
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd205
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd205
ifEnd205:
	j ifEnd204
elseStart204:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart206
	lw $t0, _A_7
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd207
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd207
ifEnd207:
	j ifEnd206
elseStart206:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart208
	lw $t0, _A_7
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd209
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd209
ifEnd209:
	j ifEnd208
elseStart208:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart210
	lw $t0, _A_7
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd211
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd211
ifEnd211:
	j ifEnd210
elseStart210:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart212
	lw $t0, _A_7
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd213
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd213
ifEnd213:
	j ifEnd212
elseStart212:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart214
	lw $t0, _A_7
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd215
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd215
ifEnd215:
	j ifEnd214
elseStart214:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart216
	lw $t0, _A_7
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd217
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd217
ifEnd217:
	j ifEnd216
elseStart216:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart218
	lw $t0, _A_7
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd219
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd219
ifEnd219:
	j ifEnd218
elseStart218:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart220
	lw $t0, _A_7
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd221
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd221
ifEnd221:
	j ifEnd220
elseStart220:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart222
	lw $t0, _A_7
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd223
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd223
ifEnd223:
	j ifEnd222
elseStart222:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart224
	lw $t0, _A_7
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd225
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd225
ifEnd225:
	j ifEnd224
elseStart224:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart226
	lw $t0, _A_7
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd227
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd227
ifEnd227:
	j ifEnd226
elseStart226:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart228
	lw $t0, _A_7
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd229
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd229
ifEnd229:
	j ifEnd228
elseStart228:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd230
	lw $t0, _A_7
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd231
	li $t0, 7
	sw $t0, 0($sp)
	j ifEnd231
ifEnd231:
	j ifEnd230
ifEnd230:
ifEnd228:
ifEnd226:
ifEnd224:
ifEnd222:
ifEnd220:
ifEnd218:
ifEnd216:
ifEnd214:
ifEnd212:
ifEnd210:
ifEnd208:
ifEnd206:
ifEnd204:
ifEnd202:
	j ifEnd201
elseStart201:
	lw $t0, 8($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart232
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart233
	lw $t0, _A_8
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd234
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd234
ifEnd234:
	j ifEnd233
elseStart233:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart235
	lw $t0, _A_8
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd236
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd236
ifEnd236:
	j ifEnd235
elseStart235:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart237
	lw $t0, _A_8
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd238
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd238
ifEnd238:
	j ifEnd237
elseStart237:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart239
	lw $t0, _A_8
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd240
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd240
ifEnd240:
	j ifEnd239
elseStart239:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart241
	lw $t0, _A_8
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd242
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd242
ifEnd242:
	j ifEnd241
elseStart241:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart243
	lw $t0, _A_8
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd244
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd244
ifEnd244:
	j ifEnd243
elseStart243:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart245
	lw $t0, _A_8
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd246
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd246
ifEnd246:
	j ifEnd245
elseStart245:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart247
	lw $t0, _A_8
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd248
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd248
ifEnd248:
	j ifEnd247
elseStart247:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart249
	lw $t0, _A_8
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd250
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd250
ifEnd250:
	j ifEnd249
elseStart249:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart251
	lw $t0, _A_8
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd252
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd252
ifEnd252:
	j ifEnd251
elseStart251:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart253
	lw $t0, _A_8
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd254
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd254
ifEnd254:
	j ifEnd253
elseStart253:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart255
	lw $t0, _A_8
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd256
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd256
ifEnd256:
	j ifEnd255
elseStart255:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart257
	lw $t0, _A_8
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd258
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd258
ifEnd258:
	j ifEnd257
elseStart257:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart259
	lw $t0, _A_8
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd260
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd260
ifEnd260:
	j ifEnd259
elseStart259:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd261
	lw $t0, _A_8
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd262
	li $t0, 8
	sw $t0, 0($sp)
	j ifEnd262
ifEnd262:
	j ifEnd261
ifEnd261:
ifEnd259:
ifEnd257:
ifEnd255:
ifEnd253:
ifEnd251:
ifEnd249:
ifEnd247:
ifEnd245:
ifEnd243:
ifEnd241:
ifEnd239:
ifEnd237:
ifEnd235:
ifEnd233:
	j ifEnd232
elseStart232:
	lw $t0, 8($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart263
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart264
	lw $t0, _A_9
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd265
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd265
ifEnd265:
	j ifEnd264
elseStart264:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart266
	lw $t0, _A_9
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd267
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd267
ifEnd267:
	j ifEnd266
elseStart266:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart268
	lw $t0, _A_9
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd269
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd269
ifEnd269:
	j ifEnd268
elseStart268:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart270
	lw $t0, _A_9
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd271
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd271
ifEnd271:
	j ifEnd270
elseStart270:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart272
	lw $t0, _A_9
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd273
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd273
ifEnd273:
	j ifEnd272
elseStart272:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart274
	lw $t0, _A_9
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd275
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd275
ifEnd275:
	j ifEnd274
elseStart274:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart276
	lw $t0, _A_9
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd277
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd277
ifEnd277:
	j ifEnd276
elseStart276:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart278
	lw $t0, _A_9
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd279
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd279
ifEnd279:
	j ifEnd278
elseStart278:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart280
	lw $t0, _A_9
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd281
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd281
ifEnd281:
	j ifEnd280
elseStart280:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart282
	lw $t0, _A_9
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd283
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd283
ifEnd283:
	j ifEnd282
elseStart282:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart284
	lw $t0, _A_9
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd285
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd285
ifEnd285:
	j ifEnd284
elseStart284:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart286
	lw $t0, _A_9
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd287
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd287
ifEnd287:
	j ifEnd286
elseStart286:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart288
	lw $t0, _A_9
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd289
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd289
ifEnd289:
	j ifEnd288
elseStart288:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart290
	lw $t0, _A_9
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd291
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd291
ifEnd291:
	j ifEnd290
elseStart290:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd292
	lw $t0, _A_9
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd293
	li $t0, 9
	sw $t0, 0($sp)
	j ifEnd293
ifEnd293:
	j ifEnd292
ifEnd292:
ifEnd290:
ifEnd288:
ifEnd286:
ifEnd284:
ifEnd282:
ifEnd280:
ifEnd278:
ifEnd276:
ifEnd274:
ifEnd272:
ifEnd270:
ifEnd268:
ifEnd266:
ifEnd264:
	j ifEnd263
elseStart263:
	lw $t0, 8($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart294
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart295
	lw $t0, _A_10
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd296
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd296
ifEnd296:
	j ifEnd295
elseStart295:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart297
	lw $t0, _A_10
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd298
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd298
ifEnd298:
	j ifEnd297
elseStart297:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart299
	lw $t0, _A_10
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd300
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd300
ifEnd300:
	j ifEnd299
elseStart299:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart301
	lw $t0, _A_10
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd302
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd302
ifEnd302:
	j ifEnd301
elseStart301:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart303
	lw $t0, _A_10
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd304
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd304
ifEnd304:
	j ifEnd303
elseStart303:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart305
	lw $t0, _A_10
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd306
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd306
ifEnd306:
	j ifEnd305
elseStart305:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart307
	lw $t0, _A_10
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd308
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd308
ifEnd308:
	j ifEnd307
elseStart307:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart309
	lw $t0, _A_10
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd310
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd310
ifEnd310:
	j ifEnd309
elseStart309:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart311
	lw $t0, _A_10
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd312
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd312
ifEnd312:
	j ifEnd311
elseStart311:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart313
	lw $t0, _A_10
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd314
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd314
ifEnd314:
	j ifEnd313
elseStart313:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart315
	lw $t0, _A_10
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd316
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd316
ifEnd316:
	j ifEnd315
elseStart315:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart317
	lw $t0, _A_10
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd318
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd318
ifEnd318:
	j ifEnd317
elseStart317:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart319
	lw $t0, _A_10
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd320
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd320
ifEnd320:
	j ifEnd319
elseStart319:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart321
	lw $t0, _A_10
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd322
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd322
ifEnd322:
	j ifEnd321
elseStart321:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd323
	lw $t0, _A_10
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd324
	li $t0, 10
	sw $t0, 0($sp)
	j ifEnd324
ifEnd324:
	j ifEnd323
ifEnd323:
ifEnd321:
ifEnd319:
ifEnd317:
ifEnd315:
ifEnd313:
ifEnd311:
ifEnd309:
ifEnd307:
ifEnd305:
ifEnd303:
ifEnd301:
ifEnd299:
ifEnd297:
ifEnd295:
	j ifEnd294
elseStart294:
	lw $t0, 8($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart325
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart326
	lw $t0, _A_11
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd327
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd327
ifEnd327:
	j ifEnd326
elseStart326:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart328
	lw $t0, _A_11
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd329
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd329
ifEnd329:
	j ifEnd328
elseStart328:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart330
	lw $t0, _A_11
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd331
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd331
ifEnd331:
	j ifEnd330
elseStart330:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart332
	lw $t0, _A_11
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd333
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd333
ifEnd333:
	j ifEnd332
elseStart332:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart334
	lw $t0, _A_11
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd335
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd335
ifEnd335:
	j ifEnd334
elseStart334:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart336
	lw $t0, _A_11
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd337
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd337
ifEnd337:
	j ifEnd336
elseStart336:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart338
	lw $t0, _A_11
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd339
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd339
ifEnd339:
	j ifEnd338
elseStart338:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart340
	lw $t0, _A_11
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd341
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd341
ifEnd341:
	j ifEnd340
elseStart340:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart342
	lw $t0, _A_11
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd343
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd343
ifEnd343:
	j ifEnd342
elseStart342:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart344
	lw $t0, _A_11
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd345
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd345
ifEnd345:
	j ifEnd344
elseStart344:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart346
	lw $t0, _A_11
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd347
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd347
ifEnd347:
	j ifEnd346
elseStart346:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart348
	lw $t0, _A_11
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd349
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd349
ifEnd349:
	j ifEnd348
elseStart348:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart350
	lw $t0, _A_11
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd351
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd351
ifEnd351:
	j ifEnd350
elseStart350:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart352
	lw $t0, _A_11
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd353
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd353
ifEnd353:
	j ifEnd352
elseStart352:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd354
	lw $t0, _A_11
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd355
	li $t0, 11
	sw $t0, 0($sp)
	j ifEnd355
ifEnd355:
	j ifEnd354
ifEnd354:
ifEnd352:
ifEnd350:
ifEnd348:
ifEnd346:
ifEnd344:
ifEnd342:
ifEnd340:
ifEnd338:
ifEnd336:
ifEnd334:
ifEnd332:
ifEnd330:
ifEnd328:
ifEnd326:
	j ifEnd325
elseStart325:
	lw $t0, 8($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart356
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart357
	lw $t0, _A_12
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd358
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd358
ifEnd358:
	j ifEnd357
elseStart357:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart359
	lw $t0, _A_12
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd360
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd360
ifEnd360:
	j ifEnd359
elseStart359:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart361
	lw $t0, _A_12
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd362
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd362
ifEnd362:
	j ifEnd361
elseStart361:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart363
	lw $t0, _A_12
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd364
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd364
ifEnd364:
	j ifEnd363
elseStart363:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart365
	lw $t0, _A_12
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd366
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd366
ifEnd366:
	j ifEnd365
elseStart365:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart367
	lw $t0, _A_12
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd368
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd368
ifEnd368:
	j ifEnd367
elseStart367:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart369
	lw $t0, _A_12
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd370
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd370
ifEnd370:
	j ifEnd369
elseStart369:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart371
	lw $t0, _A_12
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd372
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd372
ifEnd372:
	j ifEnd371
elseStart371:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart373
	lw $t0, _A_12
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd374
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd374
ifEnd374:
	j ifEnd373
elseStart373:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart375
	lw $t0, _A_12
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd376
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd376
ifEnd376:
	j ifEnd375
elseStart375:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart377
	lw $t0, _A_12
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd378
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd378
ifEnd378:
	j ifEnd377
elseStart377:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart379
	lw $t0, _A_12
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd380
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd380
ifEnd380:
	j ifEnd379
elseStart379:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart381
	lw $t0, _A_12
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd382
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd382
ifEnd382:
	j ifEnd381
elseStart381:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart383
	lw $t0, _A_12
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd384
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd384
ifEnd384:
	j ifEnd383
elseStart383:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd385
	lw $t0, _A_12
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd386
	li $t0, 12
	sw $t0, 0($sp)
	j ifEnd386
ifEnd386:
	j ifEnd385
ifEnd385:
ifEnd383:
ifEnd381:
ifEnd379:
ifEnd377:
ifEnd375:
ifEnd373:
ifEnd371:
ifEnd369:
ifEnd367:
ifEnd365:
ifEnd363:
ifEnd361:
ifEnd359:
ifEnd357:
	j ifEnd356
elseStart356:
	lw $t0, 8($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart387
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart388
	lw $t0, _A_13
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd389
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd389
ifEnd389:
	j ifEnd388
elseStart388:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart390
	lw $t0, _A_13
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd391
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd391
ifEnd391:
	j ifEnd390
elseStart390:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart392
	lw $t0, _A_13
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd393
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd393
ifEnd393:
	j ifEnd392
elseStart392:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart394
	lw $t0, _A_13
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd395
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd395
ifEnd395:
	j ifEnd394
elseStart394:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart396
	lw $t0, _A_13
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd397
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd397
ifEnd397:
	j ifEnd396
elseStart396:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart398
	lw $t0, _A_13
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd399
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd399
ifEnd399:
	j ifEnd398
elseStart398:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart400
	lw $t0, _A_13
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd401
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd401
ifEnd401:
	j ifEnd400
elseStart400:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart402
	lw $t0, _A_13
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd403
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd403
ifEnd403:
	j ifEnd402
elseStart402:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart404
	lw $t0, _A_13
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd405
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd405
ifEnd405:
	j ifEnd404
elseStart404:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart406
	lw $t0, _A_13
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd407
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd407
ifEnd407:
	j ifEnd406
elseStart406:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart408
	lw $t0, _A_13
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd409
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd409
ifEnd409:
	j ifEnd408
elseStart408:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart410
	lw $t0, _A_13
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd411
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd411
ifEnd411:
	j ifEnd410
elseStart410:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart412
	lw $t0, _A_13
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd413
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd413
ifEnd413:
	j ifEnd412
elseStart412:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart414
	lw $t0, _A_13
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd415
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd415
ifEnd415:
	j ifEnd414
elseStart414:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd416
	lw $t0, _A_13
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd417
	li $t0, 13
	sw $t0, 0($sp)
	j ifEnd417
ifEnd417:
	j ifEnd416
ifEnd416:
ifEnd414:
ifEnd412:
ifEnd410:
ifEnd408:
ifEnd406:
ifEnd404:
ifEnd402:
ifEnd400:
ifEnd398:
ifEnd396:
ifEnd394:
ifEnd392:
ifEnd390:
ifEnd388:
	j ifEnd387
elseStart387:
	lw $t0, 8($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd418
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart419
	lw $t0, _A_14
	lw $t1, _A_0
	slt $t0, $t0, $t1
	beqz $t0, ifEnd420
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd420
ifEnd420:
	j ifEnd419
elseStart419:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart421
	lw $t0, _A_14
	lw $t1, _A_1
	slt $t0, $t0, $t1
	beqz $t0, ifEnd422
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd422
ifEnd422:
	j ifEnd421
elseStart421:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart423
	lw $t0, _A_14
	lw $t1, _A_2
	slt $t0, $t0, $t1
	beqz $t0, ifEnd424
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd424
ifEnd424:
	j ifEnd423
elseStart423:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart425
	lw $t0, _A_14
	lw $t1, _A_3
	slt $t0, $t0, $t1
	beqz $t0, ifEnd426
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd426
ifEnd426:
	j ifEnd425
elseStart425:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart427
	lw $t0, _A_14
	lw $t1, _A_4
	slt $t0, $t0, $t1
	beqz $t0, ifEnd428
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd428
ifEnd428:
	j ifEnd427
elseStart427:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart429
	lw $t0, _A_14
	lw $t1, _A_5
	slt $t0, $t0, $t1
	beqz $t0, ifEnd430
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd430
ifEnd430:
	j ifEnd429
elseStart429:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart431
	lw $t0, _A_14
	lw $t1, _A_6
	slt $t0, $t0, $t1
	beqz $t0, ifEnd432
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd432
ifEnd432:
	j ifEnd431
elseStart431:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart433
	lw $t0, _A_14
	lw $t1, _A_7
	slt $t0, $t0, $t1
	beqz $t0, ifEnd434
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd434
ifEnd434:
	j ifEnd433
elseStart433:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart435
	lw $t0, _A_14
	lw $t1, _A_8
	slt $t0, $t0, $t1
	beqz $t0, ifEnd436
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd436
ifEnd436:
	j ifEnd435
elseStart435:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart437
	lw $t0, _A_14
	lw $t1, _A_9
	slt $t0, $t0, $t1
	beqz $t0, ifEnd438
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd438
ifEnd438:
	j ifEnd437
elseStart437:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart439
	lw $t0, _A_14
	lw $t1, _A_10
	slt $t0, $t0, $t1
	beqz $t0, ifEnd440
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd440
ifEnd440:
	j ifEnd439
elseStart439:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart441
	lw $t0, _A_14
	lw $t1, _A_11
	slt $t0, $t0, $t1
	beqz $t0, ifEnd442
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd442
ifEnd442:
	j ifEnd441
elseStart441:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart443
	lw $t0, _A_14
	lw $t1, _A_12
	slt $t0, $t0, $t1
	beqz $t0, ifEnd444
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd444
ifEnd444:
	j ifEnd443
elseStart443:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart445
	lw $t0, _A_14
	lw $t1, _A_13
	slt $t0, $t0, $t1
	beqz $t0, ifEnd446
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd446
ifEnd446:
	j ifEnd445
elseStart445:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd447
	lw $t0, _A_14
	lw $t1, _A_14
	slt $t0, $t0, $t1
	beqz $t0, ifEnd448
	li $t0, 14
	sw $t0, 0($sp)
	j ifEnd448
ifEnd448:
	j ifEnd447
ifEnd447:
ifEnd445:
ifEnd443:
ifEnd441:
ifEnd439:
ifEnd437:
ifEnd435:
ifEnd433:
ifEnd431:
ifEnd429:
ifEnd427:
ifEnd425:
ifEnd423:
ifEnd421:
ifEnd419:
	j ifEnd418
ifEnd418:
ifEnd387:
ifEnd356:
ifEnd325:
ifEnd294:
ifEnd263:
ifEnd232:
ifEnd201:
ifEnd170:
ifEnd139:
ifEnd108:
ifEnd77:
ifEnd46:
ifEnd15:
	lw $t0, 8($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 8($sp)
	j whileStart2
whileEnd2:
	lw $t0, 12($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart449
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart450
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd450
elseStart450:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart451
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd451
elseStart451:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart452
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd452
elseStart452:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart453
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd453
elseStart453:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart454
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd454
elseStart454:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart455
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd455
elseStart455:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart456
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd456
elseStart456:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart457
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd457
elseStart457:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart458
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd458
elseStart458:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart459
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd459
elseStart459:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart460
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd460
elseStart460:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart461
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd461
elseStart461:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart462
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd462
elseStart462:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart463
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd463
elseStart463:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd464
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_0
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_0
	j ifEnd464
ifEnd464:
ifEnd463:
ifEnd462:
ifEnd461:
ifEnd460:
ifEnd459:
ifEnd458:
ifEnd457:
ifEnd456:
ifEnd455:
ifEnd454:
ifEnd453:
ifEnd452:
ifEnd451:
ifEnd450:
	j ifEnd449
elseStart449:
	lw $t0, 12($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart465
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart466
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd466
elseStart466:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart467
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd467
elseStart467:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart468
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd468
elseStart468:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart469
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd469
elseStart469:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart470
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd470
elseStart470:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart471
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd471
elseStart471:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart472
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd472
elseStart472:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart473
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd473
elseStart473:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart474
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd474
elseStart474:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart475
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd475
elseStart475:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart476
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd476
elseStart476:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart477
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd477
elseStart477:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart478
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd478
elseStart478:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart479
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd479
elseStart479:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd480
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_1
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_1
	j ifEnd480
ifEnd480:
ifEnd479:
ifEnd478:
ifEnd477:
ifEnd476:
ifEnd475:
ifEnd474:
ifEnd473:
ifEnd472:
ifEnd471:
ifEnd470:
ifEnd469:
ifEnd468:
ifEnd467:
ifEnd466:
	j ifEnd465
elseStart465:
	lw $t0, 12($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart481
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart482
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd482
elseStart482:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart483
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd483
elseStart483:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart484
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd484
elseStart484:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart485
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd485
elseStart485:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart486
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd486
elseStart486:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart487
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd487
elseStart487:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart488
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd488
elseStart488:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart489
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd489
elseStart489:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart490
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd490
elseStart490:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart491
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd491
elseStart491:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart492
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd492
elseStart492:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart493
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd493
elseStart493:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart494
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd494
elseStart494:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart495
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd495
elseStart495:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd496
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_2
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_2
	j ifEnd496
ifEnd496:
ifEnd495:
ifEnd494:
ifEnd493:
ifEnd492:
ifEnd491:
ifEnd490:
ifEnd489:
ifEnd488:
ifEnd487:
ifEnd486:
ifEnd485:
ifEnd484:
ifEnd483:
ifEnd482:
	j ifEnd481
elseStart481:
	lw $t0, 12($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart497
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart498
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd498
elseStart498:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart499
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd499
elseStart499:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart500
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd500
elseStart500:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart501
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd501
elseStart501:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart502
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd502
elseStart502:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart503
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd503
elseStart503:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart504
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd504
elseStart504:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart505
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd505
elseStart505:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart506
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd506
elseStart506:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart507
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd507
elseStart507:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart508
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd508
elseStart508:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart509
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd509
elseStart509:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart510
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd510
elseStart510:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart511
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd511
elseStart511:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd512
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_3
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_3
	j ifEnd512
ifEnd512:
ifEnd511:
ifEnd510:
ifEnd509:
ifEnd508:
ifEnd507:
ifEnd506:
ifEnd505:
ifEnd504:
ifEnd503:
ifEnd502:
ifEnd501:
ifEnd500:
ifEnd499:
ifEnd498:
	j ifEnd497
elseStart497:
	lw $t0, 12($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart513
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart514
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd514
elseStart514:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart515
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd515
elseStart515:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart516
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd516
elseStart516:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart517
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd517
elseStart517:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart518
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd518
elseStart518:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart519
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd519
elseStart519:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart520
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd520
elseStart520:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart521
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd521
elseStart521:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart522
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd522
elseStart522:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart523
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd523
elseStart523:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart524
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd524
elseStart524:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart525
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd525
elseStart525:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart526
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd526
elseStart526:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart527
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd527
elseStart527:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd528
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_4
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_4
	j ifEnd528
ifEnd528:
ifEnd527:
ifEnd526:
ifEnd525:
ifEnd524:
ifEnd523:
ifEnd522:
ifEnd521:
ifEnd520:
ifEnd519:
ifEnd518:
ifEnd517:
ifEnd516:
ifEnd515:
ifEnd514:
	j ifEnd513
elseStart513:
	lw $t0, 12($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart529
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart530
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd530
elseStart530:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart531
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd531
elseStart531:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart532
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd532
elseStart532:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart533
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd533
elseStart533:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart534
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd534
elseStart534:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart535
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd535
elseStart535:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart536
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd536
elseStart536:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart537
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd537
elseStart537:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart538
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd538
elseStart538:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart539
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd539
elseStart539:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart540
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd540
elseStart540:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart541
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd541
elseStart541:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart542
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd542
elseStart542:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart543
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd543
elseStart543:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd544
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_5
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_5
	j ifEnd544
ifEnd544:
ifEnd543:
ifEnd542:
ifEnd541:
ifEnd540:
ifEnd539:
ifEnd538:
ifEnd537:
ifEnd536:
ifEnd535:
ifEnd534:
ifEnd533:
ifEnd532:
ifEnd531:
ifEnd530:
	j ifEnd529
elseStart529:
	lw $t0, 12($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart545
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart546
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd546
elseStart546:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart547
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd547
elseStart547:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart548
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd548
elseStart548:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart549
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd549
elseStart549:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart550
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd550
elseStart550:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart551
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd551
elseStart551:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart552
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd552
elseStart552:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart553
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd553
elseStart553:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart554
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd554
elseStart554:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart555
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd555
elseStart555:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart556
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd556
elseStart556:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart557
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd557
elseStart557:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart558
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd558
elseStart558:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart559
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd559
elseStart559:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd560
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_6
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_6
	j ifEnd560
ifEnd560:
ifEnd559:
ifEnd558:
ifEnd557:
ifEnd556:
ifEnd555:
ifEnd554:
ifEnd553:
ifEnd552:
ifEnd551:
ifEnd550:
ifEnd549:
ifEnd548:
ifEnd547:
ifEnd546:
	j ifEnd545
elseStart545:
	lw $t0, 12($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart561
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart562
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd562
elseStart562:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart563
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd563
elseStart563:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart564
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd564
elseStart564:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart565
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd565
elseStart565:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart566
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd566
elseStart566:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart567
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd567
elseStart567:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart568
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd568
elseStart568:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart569
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd569
elseStart569:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart570
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd570
elseStart570:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart571
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd571
elseStart571:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart572
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd572
elseStart572:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart573
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd573
elseStart573:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart574
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd574
elseStart574:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart575
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd575
elseStart575:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd576
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_7
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_7
	j ifEnd576
ifEnd576:
ifEnd575:
ifEnd574:
ifEnd573:
ifEnd572:
ifEnd571:
ifEnd570:
ifEnd569:
ifEnd568:
ifEnd567:
ifEnd566:
ifEnd565:
ifEnd564:
ifEnd563:
ifEnd562:
	j ifEnd561
elseStart561:
	lw $t0, 12($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart577
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart578
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd578
elseStart578:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart579
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd579
elseStart579:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart580
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd580
elseStart580:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart581
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd581
elseStart581:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart582
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd582
elseStart582:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart583
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd583
elseStart583:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart584
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd584
elseStart584:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart585
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd585
elseStart585:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart586
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd586
elseStart586:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart587
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd587
elseStart587:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart588
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd588
elseStart588:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart589
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd589
elseStart589:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart590
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd590
elseStart590:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart591
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd591
elseStart591:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd592
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_8
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_8
	j ifEnd592
ifEnd592:
ifEnd591:
ifEnd590:
ifEnd589:
ifEnd588:
ifEnd587:
ifEnd586:
ifEnd585:
ifEnd584:
ifEnd583:
ifEnd582:
ifEnd581:
ifEnd580:
ifEnd579:
ifEnd578:
	j ifEnd577
elseStart577:
	lw $t0, 12($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart593
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart594
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd594
elseStart594:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart595
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd595
elseStart595:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart596
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd596
elseStart596:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart597
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd597
elseStart597:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart598
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd598
elseStart598:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart599
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd599
elseStart599:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart600
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd600
elseStart600:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart601
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd601
elseStart601:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart602
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd602
elseStart602:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart603
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd603
elseStart603:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart604
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd604
elseStart604:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart605
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd605
elseStart605:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart606
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd606
elseStart606:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart607
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd607
elseStart607:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd608
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_9
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_9
	j ifEnd608
ifEnd608:
ifEnd607:
ifEnd606:
ifEnd605:
ifEnd604:
ifEnd603:
ifEnd602:
ifEnd601:
ifEnd600:
ifEnd599:
ifEnd598:
ifEnd597:
ifEnd596:
ifEnd595:
ifEnd594:
	j ifEnd593
elseStart593:
	lw $t0, 12($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart609
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart610
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd610
elseStart610:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart611
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd611
elseStart611:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart612
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd612
elseStart612:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart613
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd613
elseStart613:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart614
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd614
elseStart614:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart615
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd615
elseStart615:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart616
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd616
elseStart616:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart617
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd617
elseStart617:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart618
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd618
elseStart618:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart619
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd619
elseStart619:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart620
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd620
elseStart620:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart621
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd621
elseStart621:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart622
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd622
elseStart622:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart623
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd623
elseStart623:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd624
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_10
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_10
	j ifEnd624
ifEnd624:
ifEnd623:
ifEnd622:
ifEnd621:
ifEnd620:
ifEnd619:
ifEnd618:
ifEnd617:
ifEnd616:
ifEnd615:
ifEnd614:
ifEnd613:
ifEnd612:
ifEnd611:
ifEnd610:
	j ifEnd609
elseStart609:
	lw $t0, 12($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart625
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart626
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd626
elseStart626:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart627
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd627
elseStart627:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart628
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd628
elseStart628:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart629
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd629
elseStart629:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart630
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd630
elseStart630:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart631
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd631
elseStart631:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart632
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd632
elseStart632:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart633
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd633
elseStart633:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart634
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd634
elseStart634:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart635
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd635
elseStart635:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart636
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd636
elseStart636:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart637
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd637
elseStart637:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart638
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd638
elseStart638:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart639
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd639
elseStart639:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd640
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_11
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_11
	j ifEnd640
ifEnd640:
ifEnd639:
ifEnd638:
ifEnd637:
ifEnd636:
ifEnd635:
ifEnd634:
ifEnd633:
ifEnd632:
ifEnd631:
ifEnd630:
ifEnd629:
ifEnd628:
ifEnd627:
ifEnd626:
	j ifEnd625
elseStart625:
	lw $t0, 12($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart641
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart642
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd642
elseStart642:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart643
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd643
elseStart643:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart644
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd644
elseStart644:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart645
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd645
elseStart645:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart646
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd646
elseStart646:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart647
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd647
elseStart647:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart648
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd648
elseStart648:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart649
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd649
elseStart649:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart650
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd650
elseStart650:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart651
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd651
elseStart651:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart652
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd652
elseStart652:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart653
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd653
elseStart653:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart654
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd654
elseStart654:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart655
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd655
elseStart655:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd656
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_12
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_12
	j ifEnd656
ifEnd656:
ifEnd655:
ifEnd654:
ifEnd653:
ifEnd652:
ifEnd651:
ifEnd650:
ifEnd649:
ifEnd648:
ifEnd647:
ifEnd646:
ifEnd645:
ifEnd644:
ifEnd643:
ifEnd642:
	j ifEnd641
elseStart641:
	lw $t0, 12($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, ifEnd657
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart658
	lw $t0, _A_0
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_0
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd658
elseStart658:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart659
	lw $t0, _A_1
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_1
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd659
elseStart659:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart660
	lw $t0, _A_2
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_2
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd660
elseStart660:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart661
	lw $t0, _A_3
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_3
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd661
elseStart661:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart662
	lw $t0, _A_4
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_4
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd662
elseStart662:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart663
	lw $t0, _A_5
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_5
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd663
elseStart663:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart664
	lw $t0, _A_6
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_6
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd664
elseStart664:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart665
	lw $t0, _A_7
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_7
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd665
elseStart665:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart666
	lw $t0, _A_8
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_8
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd666
elseStart666:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart667
	lw $t0, _A_9
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_9
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd667
elseStart667:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart668
	lw $t0, _A_10
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_10
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd668
elseStart668:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart669
	lw $t0, _A_11
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_11
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd669
elseStart669:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart670
	lw $t0, _A_12
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_12
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd670
elseStart670:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart671
	lw $t0, _A_13
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_13
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd671
elseStart671:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd672
	lw $t0, _A_14
	sw $t0, 4($sp)
	lw $t0, _A_13
	sw $t0, _A_14
	lw $t0, 4($sp)
	sw $t0, _A_13
	j ifEnd672
ifEnd672:
ifEnd671:
ifEnd670:
ifEnd669:
ifEnd668:
ifEnd667:
ifEnd666:
ifEnd665:
ifEnd664:
ifEnd663:
ifEnd662:
ifEnd661:
ifEnd660:
ifEnd659:
ifEnd658:
	j ifEnd657
ifEnd657:
ifEnd641:
ifEnd625:
ifEnd609:
ifEnd593:
ifEnd577:
ifEnd561:
ifEnd545:
ifEnd529:
ifEnd513:
ifEnd497:
ifEnd481:
ifEnd465:
ifEnd449:

	jal _printarray
	lw $t0, 12($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 12($sp)
	j whileStart1
whileEnd1:
	li $v0, 10
	syscall

_printarray:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # i
	li $t0, 0
	sw $t0, 0($sp)
whileStart3:
	lw $t0, 0($sp)
	li $t1, 14
	sle $t0, $t0, $t1
	beqz $t0, whileEnd3
	lw $t0, 0($sp)
	li $t1, 0
	seq $t0, $t0, $t1
	beqz $t0, elseStart673

	lw $a0, _A_0
	jal _printi

	la $a0, str0
	lw $a1, str0Len
	jal _prints
	j ifEnd673
elseStart673:
	lw $t0, 0($sp)
	li $t1, 1
	seq $t0, $t0, $t1
	beqz $t0, elseStart674

	lw $a0, _A_1
	jal _printi

	la $a0, str1
	lw $a1, str1Len
	jal _prints
	j ifEnd674
elseStart674:
	lw $t0, 0($sp)
	li $t1, 2
	seq $t0, $t0, $t1
	beqz $t0, elseStart675

	lw $a0, _A_2
	jal _printi

	la $a0, str2
	lw $a1, str2Len
	jal _prints
	j ifEnd675
elseStart675:
	lw $t0, 0($sp)
	li $t1, 3
	seq $t0, $t0, $t1
	beqz $t0, elseStart676

	lw $a0, _A_3
	jal _printi

	la $a0, str3
	lw $a1, str3Len
	jal _prints
	j ifEnd676
elseStart676:
	lw $t0, 0($sp)
	li $t1, 4
	seq $t0, $t0, $t1
	beqz $t0, elseStart677

	lw $a0, _A_4
	jal _printi

	la $a0, str4
	lw $a1, str4Len
	jal _prints
	j ifEnd677
elseStart677:
	lw $t0, 0($sp)
	li $t1, 5
	seq $t0, $t0, $t1
	beqz $t0, elseStart678

	lw $a0, _A_5
	jal _printi

	la $a0, str5
	lw $a1, str5Len
	jal _prints
	j ifEnd678
elseStart678:
	lw $t0, 0($sp)
	li $t1, 6
	seq $t0, $t0, $t1
	beqz $t0, elseStart679

	lw $a0, _A_6
	jal _printi

	la $a0, str6
	lw $a1, str6Len
	jal _prints
	j ifEnd679
elseStart679:
	lw $t0, 0($sp)
	li $t1, 7
	seq $t0, $t0, $t1
	beqz $t0, elseStart680

	lw $a0, _A_7
	jal _printi

	la $a0, str7
	lw $a1, str7Len
	jal _prints
	j ifEnd680
elseStart680:
	lw $t0, 0($sp)
	li $t1, 8
	seq $t0, $t0, $t1
	beqz $t0, elseStart681

	lw $a0, _A_8
	jal _printi

	la $a0, str8
	lw $a1, str8Len
	jal _prints
	j ifEnd681
elseStart681:
	lw $t0, 0($sp)
	li $t1, 9
	seq $t0, $t0, $t1
	beqz $t0, elseStart682

	lw $a0, _A_9
	jal _printi

	la $a0, str9
	lw $a1, str9Len
	jal _prints
	j ifEnd682
elseStart682:
	lw $t0, 0($sp)
	li $t1, 10
	seq $t0, $t0, $t1
	beqz $t0, elseStart683

	lw $a0, _A_10
	jal _printi

	la $a0, str10
	lw $a1, str10Len
	jal _prints
	j ifEnd683
elseStart683:
	lw $t0, 0($sp)
	li $t1, 11
	seq $t0, $t0, $t1
	beqz $t0, elseStart684

	lw $a0, _A_11
	jal _printi

	la $a0, str11
	lw $a1, str11Len
	jal _prints
	j ifEnd684
elseStart684:
	lw $t0, 0($sp)
	li $t1, 12
	seq $t0, $t0, $t1
	beqz $t0, elseStart685

	lw $a0, _A_12
	jal _printi

	la $a0, str12
	lw $a1, str12Len
	jal _prints
	j ifEnd685
elseStart685:
	lw $t0, 0($sp)
	li $t1, 13
	seq $t0, $t0, $t1
	beqz $t0, elseStart686

	lw $a0, _A_13
	jal _printi

	la $a0, str13
	lw $a1, str13Len
	jal _prints
	j ifEnd686
elseStart686:
	lw $t0, 0($sp)
	li $t1, 14
	seq $t0, $t0, $t1
	beqz $t0, ifEnd687

	lw $a0, _A_14
	jal _printi

	la $a0, str14
	lw $a1, str14Len
	jal _prints
	j ifEnd687
ifEnd687:
ifEnd686:
ifEnd685:
ifEnd684:
ifEnd683:
ifEnd682:
ifEnd681:
ifEnd680:
ifEnd679:
ifEnd678:
ifEnd677:
ifEnd676:
ifEnd675:
ifEnd674:
ifEnd673:
	lw $t0, 0($sp)
	li $t1, 1
	addu $t0, $t0, $t1
	sw $t0, 0($sp)
	j whileStart3
whileEnd3:

	la $a0, str15
	lw $a1, str15Len
	jal _prints
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra

_INTERNALseed:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # seed
	sw $a0, 0($sp)
	lw $t0, 0($sp)
	sw $t0, _INTERNALX
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra

_INTERNALrandom:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	li $t0, 17
	lw $t1, _INTERNALX
	mul $t0, $t0, $t1
	li $t1, 13
	addu $t0, $t0, $t1
	li $t1, 32768
	bnez $t1, goodDiv15
	.data
divZeroErr15:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck15:
	la $a0, divZeroErr15
	jal ERROR
goodDiv15:
	remu $t0, $t0, $t1
	sw $t0, _INTERNALX
	
	lw $ra, 0($sp)
	lw $v0, _INTERNALX
	addu $sp, $sp, 4
	jr $ra
	.data
noRetErr1948269857:	.asciiz "Runtime Error: No return from function INTERNALrandom
"
	.text
	la $a0, noRetErr1948269857
	jal ERROR

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
