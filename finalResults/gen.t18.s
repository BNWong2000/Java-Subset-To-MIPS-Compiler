	.data
__havechar:	.word 0
__char:	.word 0
str0:	.byte 73, 110, 116, 101, 114, 110, 97, 108, 32, 101, 114, 114, 111, 114, 58, 32, 116, 111, 111, 32, 109, 97, 110, 121, 32, 117, 110, 103, 101, 116, 115, 33, 10, 
	.align 2
str0Len:	.word 33
__havetoken:	.word 0
__token:	.word 0
_attr:	.word 0
str1:	.byte 69, 114, 114, 111, 114, 58, 32, 101, 120, 112, 101, 99, 116, 101, 100, 32, 
	.align 2
str1Len:	.word 16
str2:	.byte 10, 
	.align 2
str2Len:	.word 1
str3:	.byte 69, 114, 114, 111, 114, 58, 32, 105, 110, 118, 97, 108, 105, 100, 32, 99, 104, 97, 114, 97, 99, 116, 101, 114, 46, 10, 
	.align 2
str3Len:	.word 26
str4:	.byte 32, 61, 32, 
	.align 2
str4Len:	.word 3
str5:	.byte 10, 
	.align 2
str5Len:	.word 1
str6:	.byte 69, 114, 114, 111, 114, 58, 32, 101, 120, 112, 101, 99, 116, 101, 100, 32, 102, 97, 99, 116, 111, 114, 46, 10, 
	.align 2
str6Len:	.word 24
_EOF:	.word 0
_TK_EOF:	.word 0
_TK_EOLN:	.word 0
_TK_NUMBER:	.word 0
_TK_ADD:	.word 0
_TK_SUB:	.word 0
_TK_MUL:	.word 0
_TK_DIV:	.word 0
_TK_LPAREN:	.word 0
_TK_RPAREN:	.word 0
_ASCII_0:	.word 0
_ASCII_9:	.word 0
_ASCII_PLUS:	.word 0
_ASCII_MINUS:	.word 0
_ASCII_STAR:	.word 0
_ASCII_SLASH:	.word 0
_ASCII_LPAREN:	.word 0
_ASCII_RPAREN:	.word 0
_ASCII_SPACE:	.word 0
_ASCII_TAB:	.word 0
_ASCII_CR:	.word 0
_ASCII_NL:	.word 0

	.text
	.globl main
main:
	jal _calculator

_calculator:

	jal _init

	jal _parser
	li $v0, 10
	syscall

_getc:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	lw $t0, __havechar
	beqz $t0, ifEnd0
	li $t0, 0
	sw $t0, __havechar
	
	lw $ra, 0($sp)
	lw $v0, __char
	addu $sp, $sp, 4
	jr $ra
	j ifEnd0
ifEnd0:

	jal _getchar
	move $t0, $v0
	
	lw $ra, 0($sp)
	move $v0, $t0
	addu $sp, $sp, 4
	jr $ra
	.data
noRetErr1:	.asciiz "Runtime Error: No return from function getc
"
	.text
	la $a0, noRetErr1
	jal ERROR

_ungetc:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # ch
	sw $a0, 0($sp)
	lw $t0, __havechar
	beqz $t0, ifEnd1

	la $a0, str0
	lw $a1, str0Len
	jal _prints

	jal _halt
	j ifEnd1
ifEnd1:
	li $t0, 1
	sw $t0, __havechar
	lw $t0, 0($sp)
	sw $t0, __char
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra

_peek:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	lw $t0, __havetoken
	beqz $t0, ifEnd2
	
	lw $ra, 0($sp)
	lw $v0, __token
	addu $sp, $sp, 4
	jr $ra
	j ifEnd2
ifEnd2:
	li $t0, 1
	sw $t0, __havetoken

	jal _scanner
	move $t0, $v0
	sw $t0, __token
	
	lw $ra, 0($sp)
	lw $v0, __token
	addu $sp, $sp, 4
	jr $ra
	.data
noRetErr2:	.asciiz "Runtime Error: No return from function peek
"
	.text
	la $a0, noRetErr2
	jal ERROR

_match:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # expect
	sw $a0, 0($sp)

	jal _peek
	move $t0, $v0
	lw $t1, 0($sp)
	sne $t0, $t0, $t1
	beqz $t0, ifEnd3

	la $a0, str1
	lw $a1, str1Len
	jal _prints

	lw $a0, 0($sp)
	jal _printc

	la $a0, str2
	lw $a1, str2Len
	jal _prints

	jal _halt
	j ifEnd3
ifEnd3:
	li $t0, 0
	sw $t0, __havetoken
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra

_scanner:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # ch
whileStart0:

	jal _getc
	move $t0, $v0
	sw $t0, 0($sp)

	lw $a0, 0($sp)
	jal _isspace
	move $t0, $v0
	beqz $t0, whileEnd0
	j whileStart0
whileEnd0:
	lw $t0, 0($sp)
	lw $t1, _EOF
	seq $t0, $t0, $t1
	beqz $t0, ifEnd4
	
	lw $ra, 4($sp)
	lw $v0, _TK_EOF
	addu $sp, $sp, 8
	jr $ra
	j ifEnd4
ifEnd4:
	lw $t0, 0($sp)
	lw $t1, _ASCII_NL
	seq $t0, $t0, $t1
	beqz $t0, ifEnd5
	
	lw $ra, 4($sp)
	lw $v0, _TK_EOLN
	addu $sp, $sp, 8
	jr $ra
	j ifEnd5
ifEnd5:
	lw $t0, 0($sp)
	lw $t1, _ASCII_PLUS
	seq $t0, $t0, $t1
	beqz $t0, ifEnd6
	
	lw $ra, 4($sp)
	lw $v0, _TK_ADD
	addu $sp, $sp, 8
	jr $ra
	j ifEnd6
ifEnd6:
	lw $t0, 0($sp)
	lw $t1, _ASCII_MINUS
	seq $t0, $t0, $t1
	beqz $t0, ifEnd7
	
	lw $ra, 4($sp)
	lw $v0, _TK_SUB
	addu $sp, $sp, 8
	jr $ra
	j ifEnd7
ifEnd7:
	lw $t0, 0($sp)
	lw $t1, _ASCII_STAR
	seq $t0, $t0, $t1
	beqz $t0, ifEnd8
	
	lw $ra, 4($sp)
	lw $v0, _TK_MUL
	addu $sp, $sp, 8
	jr $ra
	j ifEnd8
ifEnd8:
	lw $t0, 0($sp)
	lw $t1, _ASCII_SLASH
	seq $t0, $t0, $t1
	beqz $t0, ifEnd9
	
	lw $ra, 4($sp)
	lw $v0, _TK_DIV
	addu $sp, $sp, 8
	jr $ra
	j ifEnd9
ifEnd9:
	lw $t0, 0($sp)
	lw $t1, _ASCII_LPAREN
	seq $t0, $t0, $t1
	beqz $t0, ifEnd10
	
	lw $ra, 4($sp)
	lw $v0, _TK_LPAREN
	addu $sp, $sp, 8
	jr $ra
	j ifEnd10
ifEnd10:
	lw $t0, 0($sp)
	lw $t1, _ASCII_RPAREN
	seq $t0, $t0, $t1
	beqz $t0, ifEnd11
	
	lw $ra, 4($sp)
	lw $v0, _TK_RPAREN
	addu $sp, $sp, 8
	jr $ra
	j ifEnd11
ifEnd11:

	lw $a0, 0($sp)
	jal _isdigit
	move $t0, $v0
	beqz $t0, ifEnd12
	li $t0, 0
	sw $t0, _attr
whileStart1:

	lw $a0, 0($sp)
	jal _isdigit
	move $t0, $v0
	beqz $t0, whileEnd1
	lw $t0, _attr
	li $t1, 10
	mul $t0, $t0, $t1
	lw $t1, 0($sp)
	lw $t2, _ASCII_0
	subu $t1, $t1, $t2
	addu $t0, $t0, $t1
	sw $t0, _attr

	jal _getc
	move $t0, $v0
	sw $t0, 0($sp)
	j whileStart1
whileEnd1:

	lw $a0, 0($sp)
	jal _ungetc
	
	lw $ra, 4($sp)
	lw $v0, _TK_NUMBER
	addu $sp, $sp, 8
	jr $ra
	j ifEnd12
ifEnd12:

	la $a0, str3
	lw $a1, str3Len
	jal _prints

	jal _halt
	.data
noRetErr3:	.asciiz "Runtime Error: No return from function scanner
"
	.text
	la $a0, noRetErr3
	jal ERROR

_isdigit:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # ch
	sw $a0, 0($sp)
	lw $t0, 0($sp)
	lw $t1, _ASCII_0
	sge $t0, $t0, $t1
	beqz $t0, cond0
	lw $t1, 0($sp)
	lw $t2, _ASCII_9
	sle $t1, $t1, $t2
	and $t0, $t0, $t1
cond0:
	
	lw $ra, 4($sp)
	move $v0, $t0
	addu $sp, $sp, 8
	jr $ra
	.data
noRetErr4:	.asciiz "Runtime Error: No return from function isdigit
"
	.text
	la $a0, noRetErr4
	jal ERROR

_isspace:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # ch
	sw $a0, 0($sp)
	lw $t0, 0($sp)
	lw $t1, _ASCII_SPACE
	seq $t0, $t0, $t1
	bnez $t0, cond2
	lw $t1, 0($sp)
	lw $t2, _ASCII_TAB
	seq $t1, $t1, $t2
	or $t0, $t0, $t1
cond2:
	bnez $t0, cond1
	lw $t1, 0($sp)
	lw $t2, _ASCII_CR
	seq $t1, $t1, $t2
	or $t0, $t0, $t1
cond1:
	
	lw $ra, 4($sp)
	move $v0, $t0
	addu $sp, $sp, 8
	jr $ra
	.data
noRetErr5:	.asciiz "Runtime Error: No return from function isspace
"
	.text
	la $a0, noRetErr5
	jal ERROR

_parser:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # result
whileStart2:

	jal _peek
	move $t0, $v0
	lw $t1, _TK_EOF
	sne $t0, $t0, $t1
	beqz $t0, whileEnd2

	jal _E
	move $t0, $v0
	sw $t0, 0($sp)

	lw $a0, _TK_EOLN
	jal _match

	la $a0, str4
	lw $a1, str4Len
	jal _prints

	lw $a0, 0($sp)
	jal _printi

	la $a0, str5
	lw $a1, str5Len
	jal _prints
	j whileStart2
whileEnd2:
	
	lw $ra, 4($sp)
	addu $sp, $sp, 8
	jr $ra

_E:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # l
	subu $sp, $sp, 4    # r
	subu $sp, $sp, 4    # token

	jal _T
	move $t0, $v0
	sw $t0, 8($sp)
whileStart3:

	jal _peek
	move $t0, $v0
	lw $t1, _TK_ADD
	seq $t0, $t0, $t1
	bnez $t0, cond3

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _peek
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	lw $t2, _TK_SUB
	seq $t1, $t1, $t2
	or $t0, $t0, $t1
cond3:
	beqz $t0, whileEnd3

	jal _peek
	move $t0, $v0
	sw $t0, 0($sp)

	lw $a0, 0($sp)
	jal _match

	jal _T
	move $t0, $v0
	sw $t0, 4($sp)
	lw $t0, 0($sp)
	lw $t1, _TK_ADD
	seq $t0, $t0, $t1
	beqz $t0, elseStart13
	lw $t0, 8($sp)
	lw $t1, 4($sp)
	addu $t0, $t0, $t1
	sw $t0, 8($sp)
	j ifEnd13
elseStart13:
	lw $t0, 8($sp)
	lw $t1, 4($sp)
	subu $t0, $t0, $t1
	sw $t0, 8($sp)
ifEnd13:
	j whileStart3
whileEnd3:
	
	lw $ra, 12($sp)
	lw $v0, 8($sp)
	addu $sp, $sp, 16
	jr $ra
	.data
noRetErr6:	.asciiz "Runtime Error: No return from function E
"
	.text
	la $a0, noRetErr6
	jal ERROR

_T:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # l
	subu $sp, $sp, 4    # r
	subu $sp, $sp, 4    # token

	jal _F
	move $t0, $v0
	sw $t0, 8($sp)
whileStart4:

	jal _peek
	move $t0, $v0
	lw $t1, _TK_MUL
	seq $t0, $t0, $t1
	bnez $t0, cond4

	subu $sp, $sp, 4
	sw $t0, 0($sp)
	jal _peek
	lw $t0, 0($sp)
	addu $sp, $sp, 4
	move $t1, $v0
	lw $t2, _TK_DIV
	seq $t1, $t1, $t2
	or $t0, $t0, $t1
cond4:
	beqz $t0, whileEnd4

	jal _peek
	move $t0, $v0
	sw $t0, 0($sp)

	lw $a0, 0($sp)
	jal _match

	jal _F
	move $t0, $v0
	sw $t0, 4($sp)
	lw $t0, 0($sp)
	lw $t1, _TK_MUL
	seq $t0, $t0, $t1
	beqz $t0, elseStart14
	lw $t0, 8($sp)
	lw $t1, 4($sp)
	mul $t0, $t0, $t1
	sw $t0, 8($sp)
	j ifEnd14
elseStart14:
	lw $t0, 8($sp)
	lw $t1, 4($sp)
	bnez $t1, goodDiv0
	.data
divZeroErr0:	.asciiz "Runtime Error: divide by zero
"
	.text
divCheck0:
	la $a0, divZeroErr0
	jal ERROR
goodDiv0:
	divu $t0, $t0, $t1
	sw $t0, 8($sp)
ifEnd14:
	j whileStart4
whileEnd4:
	
	lw $ra, 12($sp)
	lw $v0, 8($sp)
	addu $sp, $sp, 16
	jr $ra
	.data
noRetErr7:	.asciiz "Runtime Error: No return from function T
"
	.text
	la $a0, noRetErr7
	jal ERROR

_F:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	subu $sp, $sp, 4    # result
	subu $sp, $sp, 4    # token

	jal _peek
	move $t0, $v0
	sw $t0, 0($sp)
	lw $t0, 0($sp)
	lw $t1, _TK_LPAREN
	seq $t0, $t0, $t1
	beqz $t0, elseStart15

	lw $a0, _TK_LPAREN
	jal _match

	jal _E
	move $t0, $v0
	sw $t0, 4($sp)

	lw $a0, _TK_RPAREN
	jal _match
	j ifEnd15
elseStart15:
	lw $t0, 0($sp)
	lw $t1, _TK_SUB
	seq $t0, $t0, $t1
	beqz $t0, elseStart16

	lw $a0, _TK_SUB
	jal _match

	jal _F
	move $t0, $v0
	negu $t0, $t0
	sw $t0, 4($sp)
	j ifEnd16
elseStart16:
	lw $t0, 0($sp)
	lw $t1, _TK_NUMBER
	seq $t0, $t0, $t1
	beqz $t0, elseStart17

	lw $a0, _TK_NUMBER
	jal _match
	lw $t0, _attr
	sw $t0, 4($sp)
	j ifEnd17
elseStart17:

	la $a0, str6
	lw $a1, str6Len
	jal _prints

	jal _halt
ifEnd17:
ifEnd16:
ifEnd15:
	
	lw $ra, 8($sp)
	lw $v0, 4($sp)
	addu $sp, $sp, 12
	jr $ra
	.data
noRetErr8:	.asciiz "Runtime Error: No return from function F
"
	.text
	la $a0, noRetErr8
	jal ERROR

_init:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	li $t0, 1
	negu $t0, $t0
	sw $t0, _EOF
	li $t0, 48
	sw $t0, _ASCII_0
	li $t0, 57
	sw $t0, _ASCII_9
	li $t0, 43
	sw $t0, _ASCII_PLUS
	li $t0, 45
	sw $t0, _ASCII_MINUS
	li $t0, 42
	sw $t0, _ASCII_STAR
	li $t0, 47
	sw $t0, _ASCII_SLASH
	li $t0, 40
	sw $t0, _ASCII_LPAREN
	li $t0, 41
	sw $t0, _ASCII_RPAREN
	li $t0, 32
	sw $t0, _ASCII_SPACE
	li $t0, 9
	sw $t0, _ASCII_TAB
	li $t0, 13
	sw $t0, _ASCII_CR
	li $t0, 10
	sw $t0, _ASCII_NL
	li $t0, 256
	sw $t0, _TK_EOF
	li $t0, 257
	sw $t0, _TK_NUMBER
	lw $t0, _ASCII_PLUS
	sw $t0, _TK_ADD
	lw $t0, _ASCII_MINUS
	sw $t0, _TK_SUB
	lw $t0, _ASCII_STAR
	sw $t0, _TK_MUL
	lw $t0, _ASCII_SLASH
	sw $t0, _TK_DIV
	lw $t0, _ASCII_LPAREN
	sw $t0, _TK_LPAREN
	lw $t0, _ASCII_RPAREN
	sw $t0, _TK_RPAREN
	lw $t0, _ASCII_NL
	sw $t0, _TK_EOLN
	
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
