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
%token    ASSIGN 
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
%type <expn> argumentlist
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
%type <stmt> assignment
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
                | INT       {std::cout << "found an int type" << std::endl; }
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

mainfunctiondeclaration : mainfunctiondeclarator block {}
                        ;

mainfunctiondeclarator  : identifier LB RB                  {$$ = new Declaration();}
                        ;

block                   : LCB blockstatements RCB           {$$ = $2;
                                                             if($2->hasSibling()){
                                                                AST* temp = $2;
                                                                while(temp->hasSibling()){
                                                                    temp = temp->getSibling();
                                                                    $$->addChild(temp);
                                                                }
                                                             }
                                                            }
                        | LCB RCB                           {$$ = new Statement();
                                                             $$->setAsEmptyBlock();
                                                            }
                        ;

blockstatements         : blockstatement                    {$$ = $1;}
                        | blockstatements blockstatement    {$$ = $1;
                                                             $$->addSibling($2);
                                                            }
                        ;

blockstatement          : variabledeclaration       {$$ = new Statement();
                                                     $$->setAsBlock($1);}
                        | statement                 {$$ = $1;}
                        ;

statement               : block                                         {$$ = $1;}
                        | SC                                            {$$ = new Statement();
                                                                         $$->setAsNull();
                                                                        }
                        | statementexpression SC                        {$$ = $1;
                                                                        }
                        | BREAK SC                                      {$$ = new Statement();
                                                                         $$->setAsBreak();
                                                                        }
                        | RET expression SC                             {$$ = new Statement();
                                                                         $$->setAsReturn($2);
                                                                        }
                        | RET SC                                        {$$ = new Statement();
                                                                         $$->setAsReturn();
                                                                        }
                        | IF LB expression RB statement                 {$$ = new Statement();
                                                                         $$->setAsIf($3, $5);
                                                                        }
                        | IF LB expression RB statement ELSE statement  {$$ = new Statement();
                                                                         $$->setAsIfElse($3, $5, $7);
                                                                        }
                        | WHILE LB expression RB statement              {$$ = new Statement();
                                                                         $$->setAsWhile($3, $5);
                                                                        }
                        ;

statementexpression     : assignment                    {$$ = $1;}
                        | functioninvocation            {$$ = new Statement();
                                                         $$->setAsFunctionStatement($1);
                                                        }
                        ;

primary                 : literal                       {$$ = $1;}
                        | LB expression RB              {$$ = $2;}
                        | functioninvocation            {$$ = $1;}
                        ;

argumentlist            : expression                    {$$ = $1;}
                        | argumentlist COM expression   {$$ = $1;
                                                         $$->addSibling($3);
                                                        }
                        ;

functioninvocation      : identifier LB argumentlist RB {$$ = new Expression();
                                                         $$->setAsFunctionCall($1, $3); 
                                                        }
                        | identifier LB RB              {$$ = new Expression();
                                                         $$->setAsFunctionCall($1);
                                                        }
                        ;

postfixexpression       : primary                   {$$ = $1;}
                        | identifier                {$$ = $1;}
                        ;

unaryexpression         : SUB unaryexpression       {$$ = new Expression();
                                                     $$->setAsUnary(op_SUB, $2);
                                                    }
                        | NOT unaryexpression       {$$ = new Expression();
                                                     $$->setAsUnary(op_NOT, $2);
                                                    }
                        | postfixexpression         {$$ = $1;}
                        ;

multiplicativeexpression: unaryexpression                       {$$ = $1;}
                        | multiplicativeexpression MULT unaryexpression     {$$ = new Expression();
                                                                             $$->setAsArithmetic($1, op_MULT, $3);
                                                                            }
                        | multiplicativeexpression DIV unaryexpression      {$$ = new Expression();
                                                                             $$->setAsArithmetic($1, op_DIV, $3);
                                                                            }
                        | multiplicativeexpression MOD unaryexpression      {$$ = new Expression();
                                                                             $$->setAsArithmetic($1, op_MOD, $3);
                                                                            }
                        ;

additiveexpression      : multiplicativeexpression              {$$ = $1;}
                        | additiveexpression ADD multiplicativeexpression   {$$ = new Expression();
                                                                             $$->setAsArithmetic($1, op_ADD, $3);
                                                                            }
                        | additiveexpression SUB multiplicativeexpression   {$$ = new Expression();
                                                                             $$->setAsArithmetic($1, op_SUB, $3);
                                                                            }
                        ;

relationalexpression    : additiveexpression                    {$$ = $1;}    
                        | relationalexpression LT additiveexpression    {$$ = new Expression();
                                                                         $$->setAsRelational($1, op_LT, $3);
                                                                        }
                        | relationalexpression GT additiveexpression    {$$ = new Expression();
                                                                         $$->setAsRelational($1, op_GT, $3);
                                                                        }
                        | relationalexpression LE additiveexpression    {$$ = new Expression();
                                                                         $$->setAsRelational($1, op_LE, $3);
                                                                        }
                        | relationalexpression GE additiveexpression    {$$ = new Expression();
                                                                         $$->setAsRelational($1, op_GE, $3);
                                                                        }		
                        ;

equalityexpression      : relationalexpression                      {$$ = $1;}
                        | equalityexpression EQ relationalexpression		{$$ = new Expression();
                                                                             $$->setAsEquality($1, op_EQ, $3);
                                                                            }
                        | equalityexpression NEQ relationalexpression		{$$ = new Expression();
                                                                             $$->setAsEquality($1, op_NEQ, $3);
                                                                            }
                        ;

conditionalandexpression: equalityexpression                        {$$ = $1;}
                        | conditionalandexpression AND equalityexpression 	{$$ = new Expression();
                                                                             $$->setAsConditional($1, op_AND, $3);	
                                                                            }
                        ;

conditionalorexpression : conditionalandexpression	{$$ = $1;}
                        | conditionalorexpression OR conditionalandexpression	{$$ = new Expression();
                                                                                 $$->setAsConditional($1, op_OR, $3);
                                                                                }
                        ;

assignmentexpression    : conditionalorexpression                   {$$ = $1;}
                        | assignment			                    {$$ = new Expression();
                                                                     $$->setAsAssignment($1);
                                                                    }
                        ;

assignment              : identifier ASSIGN assignmentexpression {$$ = new Statement(); 
                                                                  $$->setAsAssignment($1, $3);
                                                                 }
                        ;

expression              : assignmentexpression                  {$$ = $1;}
                        ;
%%

void JCC::Parser::error(const location_type &loc, const std::string &errmsg)
{
   std::cerr << "Error: " << errmsg << " at " << loc << "\n";
}
