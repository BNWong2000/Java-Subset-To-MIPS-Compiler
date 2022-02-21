%skeleton "lalr1.cc"
%require "3.7"

%defines
%define api.namespace {JCC}
%define api.parser.class {Parser}
%locations

%code requires{
    #include <string>
    #include <memory>
    
    namespace JCC{
        class MyLexer;
    }
}


%code{
    #include <iostream>
    #include "main.hpp"

    #undef  yyLex
    #define yyLex MyLexer->yyLex



}


%parse-param {std::unique_ptr<JCC::MyLexer> &lexer}

%union{
    int ival;
    std::string *str;
}

%token    <str>  T_ID
%token    <ival> T_NUM
%token    T_ADD
%token    T_SUB
%token    T_DIV
%token    T_MULT
%token    T_MOD
%token    T_LT
%token    T_GT
%token    T_GE
%token    T_LE
%token    T_EQ
%token    T_BEQ
%token    T_NEQ
%token    T_NOT
%token    T_AND
%token    T_OR
%token    T_IF
%token    T_ELSE
%token    T_WHILE
%token    T_FOR
%token    T_BREAK
%token    T_RET
%token    T_STR
%token    T_LB
%token    T_RB
%token    T_RCB
%token    T_LCB
%token    T_SC
%token    T_COM
%token    T_TRUE
%token    T_FALSE
%token    T_BOOL
%token    T_INT
%token    T_VOID
%token    T_WARN
%token    T_ERR

%start S

%%
start           : /* empty */
                | globaldeclarations
                ;

literal         : NUMBER
                | STRING
                | TRUE
                | FALSE
                ;

type            : BOOLEAN
                | INT
                ;

globaldeclarations      : globaldeclaration
                        | globaldeclarations globaldeclaration
                        ;

globaldeclaration       : variabledeclaration
                        | functiondeclaration
                        | mainfunctiondeclaration
                        ;

variabledeclaration     : type identifier ';'
                        ;

identifier              : ID
                        ;

functiondeclaration     : functionheader block
                        ;

functionheader          : type functiondeclarator
                        | VOID functiondeclarator
                        ;

functiondeclarator      : identifier '(' formalparameterlist ')'
                        | identifier '(' ')'
                        ;

formalparameterlist     : formalparameter
                        | formalparameterlist ',' formalparameter
                        ;

formalparameter         : type identifier
                        ;

mainfunctiondeclaration : mainfunctiondeclarator block
                        ;

mainfunctiondeclarator  : identifier '(' ')'
                        ;

block                   : '{' blockstatements '}'
                        | '{' '}'
                        ;

blockstatements         : blockstatement
                        | blockstatements blockstatement
                        ;

blockstatement          : variabledeclaration
                        | statement
                        ;

statement               : block
                        | ';'
                        | statementexpression ';'
                        | BREAK ';'
                        | RETURN expression ';'
                        | RETURN ';'
                        | IF '(' expression ')' statement
                        | IF '(' expression ')' statement ELSE statement
                        | WHILE '(' expression ')' statement
                        ;

statementexpression     : assignment
                        | functioninvocation
                        ;

primary                 : literal
                        | '(' expression ')'
                        | functioninvocation
                        ;

argumentlist            : expression
                        | argumentlist ',' expression
                        ;

functioninvocation      : identifier '(' argumentlist ')'
                        | identifier '(' ')'
                        ;

postfixexpression       : primary
                        | identifier
                        ;

unaryexpression         : '-' unaryexpression
                        | '!' unaryexpression
                        | postfixexpression
                        ;

multiplicativeexpression: unaryexpression
                        | multiplicativeexpression '*' unaryexpression
                        | multiplicativeexpression '/' unaryexpression
                        | multiplicativeexpression '%' unaryexpression
                        ;

additiveexpression      : multiplicativeexpression
                        | additiveexpression '+' multiplicativeexpression
                        | additiveexpression '-' multiplicativeexpression
                        ;

relationalexpression    : additiveexpression
                        | relationalexpression '<' additiveexpression
                        | relationalexpression '>' additiveexpression
                        | relationalexpression LE additiveexpression
                        | relationalexpression GE additiveexpression
                        ;

equalityexpression      : relationalexpression
                        | equalityexpression EQ relationalexpression
                        | equalityexpression NE relationalexpression
                        ;

conditionalandexpression: equalityexpression
                        | conditionalandexpression AND equalityexpression
                        ;

conditionalorexpression : conditionalandexpression
                        | conditionalorexpression OR conditionalandexpression
                        ;

assignmentexpression    : conditionalorexpression
                        | assignment
                        ;

assignment              : identifier '=' assignmentexpression
                        ;

expression              : assignmentexpression
                        ;
%%
