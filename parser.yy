%skeleton "lalr1.cc"
%require "3.7"

%defines
%define api.namespace {JCC}
%define api.parser.class {Parser}
%locations


%code requires{
    #include <string>
    #include <memory>
    #include "ast.hpp"

    namespace JCC{
        class MyLexer;
    }
    class Driver;
}

// %parse-param {std::unique_ptr<JCC::MyLexer> &lexer}
%parse-param {Driver & driver}

%code{
    #include <iostream>
    #include "driver.hpp"

    #undef  yylex
    #define yylex driver.getToken
}
%define api.token.prefix {T_}


%union{
    int ival;
    std::string *str;

    Prog* prog;

    Statement* stmt;
    Expression* expn;
    Declaration* decl;
}

%token    <str>  ID "identifier"
%token    <ival> NUM "number"
%token    ADD '+'
%token    SUB '-'
%token    DIV '/'
%token    MULT '*'
%token    MOD '%'
%token    LT '<'
%token    GT '>'
%token    GE 
%token    LE 
%token    ASIGN '='
%token    EQ 
%token    NEQ 
%token    NOT '!'
%token    AND 
%token    OR 
%token    IF 
%token    ELSE
%token    WHILE
%token    BREAK
%token    RET
%token    STR
%token    LB '('
%token    RB ')'
%token    RCB '{'
%token    LCB '}'
%token    SC
%token    COM
%token    TRUE
%token    FALSE
%token    BOOL
%token    INT
%token    VOID
%token    WARN
%token    ERR

%type <expn> literal 
%type <decl> type
%type <decl> globaldeclarations
%type <decl> globaldeclaration
%type <decl> variabledeclaration
%type <expn> identifier
%type <decl> functiondeclaration
%type <decl> functionheader
%type <decl> functiondeclarator
%type <decl> formalparameterlist
%type <decl> formalparameter
%type <decl> mainfunctiondeclaration
%type <decl> mainfunctiondeclarator
%type <stmt> block
%type <stmt> blockstatements
%type <stmt> blockstatement
%type <stmt> statement
%type <stmt> statementexpression
%type <expn> primary
%type <decl> argumentlist
%type <decl> functioninvocation
%type <expn> postfixexpression
%type <expn> unaryexpression
%type <expn> multiplicativeexpression
%type <expn> additiveexpression
%type <expn> relationalexpression
%type <expn> equalityexpression
%type <expn> conditionalandexpression
%type <expn> conditionalorexpression
%type <expn> assignmentexpression
%type <expn> assignment
%type <expn> expression


%start start

%%
start           : /* empty */       {std::cout <<"Here1" << std::endl; driver.tree = new Prog(driver.getFileName());}
                | globaldeclarations {std::cout <<"Here2" << std::endl; }
                ;

literal         : NUM
                | STR
                | TRUE
                | FALSE
                ;

type            : BOOL
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
                        | RET expression ';'
                        | RET ';'
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
                        | equalityexpression NEQ relationalexpression
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

void JCC::Parser::error(const location_type &loc, const std::string &errmsg)
{
   std::cerr << "Error: " << errmsg << " at " << loc << "\n";
}
