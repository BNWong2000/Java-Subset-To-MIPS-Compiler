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
%token    ADD "+"
%token    SUB '-'
%token    DIV '/'
%token    MULT '*'
%token    MOD '%'
%token    LT '<'
%token    GT '>'
%token    GE 
%token    LE 
%token    ASSIGN "="
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
%token    SC ';'
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
%type <expn> functioninvocation
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
start           : /* empty */           {   std::cout <<"Here1" << std::endl; driver.tree = new Prog(driver.getFileName());}
                | globaldeclarations    {   std::cout <<"Here2" << std::endl; 
                                            driver.tree = $1;
                                        }
                ;

literal         : NUM
                | STR
                | TRUE
                | FALSE
                ;

type            : BOOL
                | INT       {std::cout << "found an int type" << std::endl;}
                ;

globaldeclarations      : globaldeclaration                     
                        | globaldeclarations globaldeclaration  
                        ;

globaldeclaration       : variabledeclaration
                        | functiondeclaration
                        | mainfunctiondeclaration {std::cout << "main" << std::endl;}
                        ;

variabledeclaration     : type identifier SC
                        ;

identifier              : ID                {std::cout << "Parser found an identifier: " << $1->c_str() << std::endl;}
                        ;

functiondeclaration     : functionheader block
                        ;

functionheader          : type functiondeclarator
                        | VOID functiondeclarator
                        ;

functiondeclarator      : identifier LB formalparameterlist RB
                        | identifier LB RB	{std::cout << "Parser found a function declarator" << std::endl;}
                        ;

formalparameterlist     : formalparameter
                        | formalparameterlist COM formalparameter
                        ;

formalparameter         : type identifier
                        ;

mainfunctiondeclaration : mainfunctiondeclarator block {std::cout << "Main Function + block" << std::endl;}
                        ;

mainfunctiondeclarator  : identifier LB RB {std::cout << "Main Function" << std::endl;}
                        ;

block                   : LCB blockstatements RCB {std::cout << "Block Function" << std::endl;}
                        | LCB RCB
                        ;

blockstatements         : blockstatement
                        | blockstatements blockstatement
                        ;

blockstatement          : variabledeclaration
                        | statement
                        ;

statement               : block
                        | SC
                        | statementexpression SC
                        | BREAK SC
                        | RET expression SC
                        | RET SC
                        | IF LB expression RB statement
                        | IF LB expression RB statement ELSE statement
                        | WHILE LB expression RB statement
                        ;

statementexpression     : assignment
                        | functioninvocation
                        ;

primary                 : literal
                        | LB expression RB
                        | functioninvocation
                        ;

argumentlist            : expression
                        | argumentlist COM expression
                        ;

functioninvocation      : identifier LB argumentlist RB
                        | identifier LB RB
                        ;

postfixexpression       : primary
                        | identifier
                        ;

unaryexpression         : SUB unaryexpression
                        | NOT unaryexpression
                        | postfixexpression
                        ;

multiplicativeexpression: unaryexpression
                        | multiplicativeexpression MULT unaryexpression
                        | multiplicativeexpression DIV unaryexpression
                        | multiplicativeexpression MOD unaryexpression
                        ;

additiveexpression      : multiplicativeexpression
                        | additiveexpression ADD multiplicativeexpression
                        | additiveexpression SUB multiplicativeexpression
                        ;

relationalexpression    : additiveexpression
                        | relationalexpression LT additiveexpression
                        | relationalexpression GT additiveexpression
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

assignment              : identifier ASSIGN assignmentexpression
                        ;

expression              : assignmentexpression
                        ;
%%

void JCC::Parser::error(const location_type &loc, const std::string &errmsg)
{
   std::cerr << "Error: " << errmsg << " at " << loc << "\n";
}
