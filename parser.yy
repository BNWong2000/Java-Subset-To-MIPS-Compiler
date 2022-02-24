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

%token    <str>  ID 
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
%token    <str> STR
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

%destructor { delete $$; } literal type globaldeclarations globaldeclaration variabledeclaration identifier functiondeclaration functionheader functiondeclarator formalparameterlist formalparameter mainfunctiondeclaration mainfunctiondeclarator block blockstatements blockstatement statement statementexpression primary argumentlist functioninvocation postfixexpression unaryexpression multiplicativeexpression additiveexpression relationalexpression equalityexpression conditionalandexpression conditionalorexpression assignmentexpression assignment expression 

%start start

%%
start           : /* empty */           {   driver.tree = new Prog(driver.getFileName());}
                | globaldeclarations    {   
                                            driver.tree = new Prog(driver.getFileName());
                                            driver.tree->addChild($1);
                                            if($1->hasSibling()){
                                                AST* temp = $1;
                                                while(temp->hasSibling()){
                                                    temp = temp->getSibling();
                                                    driver.tree->addChild(temp);
                                                }
                                                std::cout << "HI4" << std::endl;
                                            }
                                        }
                ;

literal         : NUM                   {$$ = new Expression(@$.begin.line);
                                         $$->setAsNumber($1); 
                                        }
                | STR                   {$$ = new Expression(@$.begin.line);
                                         $$->setAsString($1); 
                                        }
                | TRUE                  {$$ = new Expression(@$.begin.line);
                                         $$->setAsBool(true);
                                        }
                | FALSE                 {$$ = new Expression(@$.begin.line);
                                         $$->setAsBool(false);
                                        }
                ;

type            : BOOL                                              {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsType(var_BOOL); 
                                                                    }
                | INT                                               {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsType(var_INT); 
                                                                    }
                ;

globaldeclarations      : globaldeclaration                         {$$ = $1;}           
                        | globaldeclarations globaldeclaration      {$$ = $1;
                                                                     AST *temp = $1;
                                                                     while(temp->hasSibling()){
                                                                         temp = temp->getSibling();
                                                                     }
                                                                     temp->addSibling($2);
                                                                     // $$->addSibling($2);
                                                                    }
                        ;

globaldeclaration       : variabledeclaration                       {$$ = $1;}
                        | functiondeclaration                       {$$ = $1;}
                        | mainfunctiondeclaration                   {$$ = $1;}
                        ;

variabledeclaration     : type identifier SC                        {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsVariable($2, $1->getVar());
                                                                    }
                        ;

identifier              : ID                                        {$$ = new Expression(@$.begin.line);
                                                                     $$->setAsIdentifier($1->c_str());}
                        ;

functiondeclaration     : functionheader block                      {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsFunction($1, $2);
                                                                    }
                        ;

functionheader          : type functiondeclarator                   {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsFunctionHeader($2, $1->getVar());
                                                                    }
                        | VOID functiondeclarator                   {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsFunctionHeader($2, var_VOID);
                                                                    }
                        ;

functiondeclarator      : identifier LB formalparameterlist RB      {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsDeclarator($1, $3);
                                                                     if($3->hasSibling()){
                                                                        AST* temp = $3;
                                                                        while(temp->hasSibling()){
                                                                            temp = temp->getSibling();
                                                                            $$->addChild(temp);
                                                                        }
                                                                     }
                                                                    }
                        | identifier LB RB	                        {$$ = new Declaration(@$.begin.line);
                                                                     $$->setAsDeclarator($1);
                                                                    }
                        ;

formalparameterlist     : formalparameter                           {$$ = $1;}
                        | formalparameterlist COM formalparameter   {$$ = $1;
                                                                     AST *temp = $1;
                                                                     while(temp->hasSibling()){
                                                                         temp = temp->getSibling();
                                                                     }
                                                                     temp->addSibling($3);
                                                                     // $$->addSibling($3);
                                                                    }
                        ;

formalparameter         : type identifier               {$$ = new Declaration(@$.begin.line);
                                                         $$->setAsParameter($1->getVar(), $2);
                                                        }
                        ;

mainfunctiondeclaration : mainfunctiondeclarator block  {$$ = new Declaration(@$.begin.line);
                                                         $$->setAsFunction($1, $2);

                                                        }
                        ;

mainfunctiondeclarator  : identifier LB RB                  {$$ = new Declaration(@$.begin.line);
                                                             $$->setAsDeclarator($1);
                                                            }
                        ;

block                   : LCB blockstatements RCB           {$$ = new Statement(@$.begin.line);
                                                             $$->setAsBlock($2);
                                                             if($2->hasSibling()){
                                                                AST* temp = $2;
                                                                while(temp->hasSibling()){
                                                                    temp = temp->getSibling();
                                                                    $$->addChild(temp);
                                                                }
                                                             }
                                                             std::cout << "block " << " on line: " << @$.begin.line << std::endl;
                                                             $$->print(1);
                                                            }
                        | LCB RCB                           {$$ = new Statement(@$.begin.line);
                                                             $$->setAsEmptyBlock();
                                                            }
                        ;

blockstatements         : blockstatement                    {$$ = $1;
                                                             std::cout << "block stmts single" << " on line: " << @$.begin.line << std::endl;
                                                             $$->print(1);}
                        | blockstatements blockstatement    {$$ = $1;
                                                             AST *temp = $1;
                                                             while(temp->hasSibling()){
                                                                 temp = temp->getSibling();
                                                             }
                                                             temp->addSibling($2);
                                                             // $$->addSibling($2);
                                                             // std::cout << "block stmtsssss" << " on line: " << @$.begin.line << std::endl;
                                                             // $1->print(1);
                                                             // $2->print(1);
                                                            }
                        ;

blockstatement          : variabledeclaration       {$$ = new Statement(@$.begin.line);
                                                     $$->setAsBlock($1);}
                        | statement                 {$$ = $1;
                                                     std::cout << "block stmt" << " on line: " << @$.begin.line << std::endl;
                                                     // $$->print(1);
                                                    }
                        ;

statement               : block                                         {$$ = $1;}
                        | SC                                            {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsNull();
                                                                        }
                        | statementexpression SC                        {$$ = $1;}
                        | BREAK SC                                      {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsBreak();
                                                                        }
                        | RET expression SC                             {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsReturn($2);
                                                                        }
                        | RET SC                                        {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsReturn();
                                                                        }
                        | IF LB expression RB statement                 {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsIf($3, $5);
                                                                        }
                        | IF LB expression RB statement ELSE statement  {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsIfElse($3, $5, $7);
                                                                        }
                        | WHILE LB expression RB statement              {$$ = new Statement(@$.begin.line);
                                                                         $$->setAsWhile($3, $5);
                                                                        }
                        ;

statementexpression     : assignment                    {$$ = $1;
                                                        }
                        | functioninvocation            {$$ = new Statement(@$.begin.line);
                                                         $$->setAsFunctionStatement($1);
                                                        }
                        ;

primary                 : literal                       {$$ = $1;}
                        | LB expression RB              {$$ = $2;}
                        | functioninvocation            {$$ = $1;}
                        ;

argumentlist            : expression                    {$$ = $1;}
                        | argumentlist COM expression   {$$ = $1;
                                                         AST *temp = $1;
                                                         while(temp->hasSibling()){
                                                             temp = temp->getSibling();
                                                         }
                                                         temp->addSibling($3);
                                                         // $$->addSibling($3);
                                                        }
                        ;

functioninvocation      : identifier LB argumentlist RB {$$ = new Expression(@$.begin.line);
                                                         $$->setAsFunctionCall($1, $3); 
                                                         if($3->hasSibling()){
                                                            AST* temp = $3;
                                                            while(temp->hasSibling()){
                                                                temp = temp->getSibling();
                                                                $$->addChild(temp);
                                                            }
                                                        }
                                                        }
                        | identifier LB RB              {$$ = new Expression(@$.begin.line);
                                                         $$->setAsFunctionCall($1);
                                                        }
                        ;

postfixexpression       : primary                   {$$ = $1;}
                        | identifier                {$$ = $1;}
                        ;

unaryexpression         : SUB unaryexpression       {$$ = new Expression(@$.begin.line);
                                                     $$->setAsUnary(op_SUB, $2);
                                                    }
                        | NOT unaryexpression       {$$ = new Expression(@$.begin.line);
                                                     $$->setAsUnary(op_NOT, $2);
                                                    }
                        | postfixexpression         {$$ = $1;}
                        ;

multiplicativeexpression: unaryexpression                       {$$ = $1;}
                        | multiplicativeexpression MULT unaryexpression     {$$ = new Expression(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_MULT, $3);
                                                                            }
                        | multiplicativeexpression DIV unaryexpression      {$$ = new Expression(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_DIV, $3);
                                                                            }
                        | multiplicativeexpression MOD unaryexpression      {$$ = new Expression(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_MOD, $3);
                                                                            }
                        ;

additiveexpression      : multiplicativeexpression              {$$ = $1;}
                        | additiveexpression ADD multiplicativeexpression   {$$ = new Expression(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_ADD, $3);
                                                                             
                                                                            }
                        | additiveexpression SUB multiplicativeexpression   {$$ = new Expression(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_SUB, $3);
                                                                            }
                        ;

relationalexpression    : additiveexpression                    {$$ = $1;}    
                        | relationalexpression LT additiveexpression    {$$ = new Expression(@$.begin.line);
                                                                         $$->setAsRelational($1, op_LT, $3);
                                                                        }
                        | relationalexpression GT additiveexpression    {$$ = new Expression(@$.begin.line);
                                                                         $$->setAsRelational($1, op_GT, $3);
                                                                        }
                        | relationalexpression LE additiveexpression    {$$ = new Expression(@$.begin.line);
                                                                         $$->setAsRelational($1, op_LE, $3);
                                                                        }
                        | relationalexpression GE additiveexpression    {$$ = new Expression(@$.begin.line);
                                                                         $$->setAsRelational($1, op_GE, $3);
                                                                        }		
                        ;

equalityexpression      : relationalexpression                      {$$ = $1;}
                        | equalityexpression EQ relationalexpression		{$$ = new Expression(@$.begin.line);
                                                                             $$->setAsEquality($1, op_EQ, $3);
                                                                            }
                        | equalityexpression NEQ relationalexpression		{$$ = new Expression(@$.begin.line);
                                                                             $$->setAsEquality($1, op_NEQ, $3);
                                                                            }
                        ;

conditionalandexpression: equalityexpression                        {$$ = $1;}
                        | conditionalandexpression AND equalityexpression 	{$$ = new Expression(@$.begin.line);
                                                                             $$->setAsConditional($1, op_AND, $3);	
                                                                            }
                        ;

conditionalorexpression : conditionalandexpression	{$$ = $1;}
                        | conditionalorexpression OR conditionalandexpression	{$$ = new Expression(@$.begin.line);
                                                                                 $$->setAsConditional($1, op_OR, $3);
                                                                                }
                        ;

assignmentexpression    : conditionalorexpression                   {$$ = $1; std::cout << "assignExp" << " on line: " << @$.begin.line << std::endl;}
                        | assignment			                    {$$ = new Expression(@$.begin.line);
                                                                     $$->setAsAssignment($1);
                                                                    }
                        ;

assignment              : identifier ASSIGN assignmentexpression {$$ = new Statement(@$.begin.line); 
                                                                  $$->setAsAssignment($1, $3);
                                                                  std::cout << "Assignment" << " on line: " << @$.begin.line << std::endl;
                                                                  $$->print(1);
                                                                 }
                        ;

expression              : assignmentexpression                  {$$ = $1;}
                        ;
%%

void JCC::Parser::error(const location_type &loc, const std::string &errmsg)
{
   std::cerr << "Error: " << errmsg << " at " << loc << "\n";
}
