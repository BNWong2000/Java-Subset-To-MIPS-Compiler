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

    AST *ast_t;
    Variables varType;
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

%type <ast_t> literal 
%type <varType> type
%type <ast_t> globaldeclarations
%type <ast_t> globaldeclaration
%type <ast_t> variabledeclaration
%type <ast_t> identifier
%type <ast_t> functiondeclaration
%type <ast_t> functionheader
%type <ast_t> functiondeclarator
%type <ast_t> formalparameterlist
%type <ast_t> formalparameter
%type <ast_t> mainfunctiondeclaration
%type <ast_t> mainfunctiondeclarator
%type <ast_t> block
%type <ast_t> blockstatements
%type <ast_t> blockstatement
%type <ast_t> statement
%type <ast_t> statementexpression
%type <ast_t> primary
%type <ast_t> argumentlist
%type <ast_t> functioninvocation
%type <ast_t> postfixexpression
%type <ast_t> unaryexpression
%type <ast_t> multiplicativeexpression
%type <ast_t> additiveexpression
%type <ast_t> relationalexpression
%type <ast_t> equalityexpression
%type <ast_t> conditionalandexpression
%type <ast_t> conditionalorexpression
%type <ast_t> assignmentexpression
%type <ast_t> assignment
%type <ast_t> expression

%destructor { delete $$; } literal globaldeclarations globaldeclaration variabledeclaration identifier functiondeclaration functionheader functiondeclarator formalparameterlist formalparameter mainfunctiondeclaration mainfunctiondeclarator block blockstatements blockstatement statement statementexpression primary argumentlist functioninvocation postfixexpression unaryexpression multiplicativeexpression additiveexpression relationalexpression equalityexpression conditionalandexpression conditionalorexpression assignmentexpression assignment expression 

%start start

%%
start           : /* empty */           {   driver.tree = new AST(driver.getFileName());}
                | globaldeclarations    {   
                                            driver.tree = new AST(driver.getFileName());
                                            driver.tree->addChild($1);
                                            if($1->hasSibling()){
                                                AST* temp = $1;
                                                while(temp->hasSibling()){
                                                    temp = temp->getSibling();
                                                    driver.tree->addChild(temp);
                                                }
                                                
                                            }
                                        }
                ;

literal         : NUM                   {$$ = new AST(@$.begin.line);
                                         $$->setAsNumber($1); 
                                        }
                | STR                   {$$ = new AST(@$.begin.line);
                                         $$->setAsString($1); 
                                        }
                | TRUE                  {$$ = new AST(@$.begin.line);
                                         $$->setAsBool(true);
                                        }
                | FALSE                 {$$ = new AST(@$.begin.line);
                                         $$->setAsBool(false);
                                        }
                ;

type            : BOOL                                              {$$ = var_BOOL; 
                                                                    }
                | INT                                               {$$ = var_INT; 
                                                                    }
                ;

globaldeclarations      : globaldeclaration                         {$$ = $1;}           
                        | globaldeclarations globaldeclaration      {$$ = $1;
                                                                     AST *temp = $1;
                                                                     while(temp->hasSibling()){
                                                                         temp = temp->getSibling();
                                                                     }
                                                                     temp->addSibling($2);
                                                                    }
                        ;

globaldeclaration       : variabledeclaration                       {$$ = $1;
                                                                     $$->setAsGlobalVariable();
                                                                    }
                        | functiondeclaration                       {$$ = $1;}
                        | mainfunctiondeclaration                   {$$ = $1;}
                        ;

variabledeclaration     : type identifier SC                        {$$ = new AST(@$.begin.line);
                                                                     $$->setAsVariable($2, $1);
                                                                    }
                        ;

identifier              : ID                                        {$$ = new AST(@$.begin.line);
                                                                     $$->setAsIdentifier($1->c_str());}
                        ;

functiondeclaration     : functionheader block                      {$$ = new AST(@$.begin.line);
                                                                     $$->setAsFunction($1, $2);
                                                                    }
                        ;

functionheader          : type functiondeclarator                   {$$ = new AST(@$.begin.line);
                                                                     $$->setAsFunctionHeader($2, $1);
                                                                    }
                        | VOID functiondeclarator                   {$$ = new AST(@$.begin.line);
                                                                     $$->setAsFunctionHeader($2, var_VOID);
                                                                    }
                        ;

functiondeclarator      : identifier LB formalparameterlist RB      {$$ = new AST(@$.begin.line);
                                                                     $$->setAsDeclarator($1, $3);
                                                                     if($3->hasSibling()){
                                                                        AST* temp = $3;
                                                                        while(temp->hasSibling()){
                                                                            temp = temp->getSibling();
                                                                            $$->addChild(temp);
                                                                        }
                                                                     }
                                                                    }
                        | identifier LB RB	                        {$$ = new AST(@$.begin.line);
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
                                                                    }
                        ;

formalparameter         : type identifier               {$$ = new AST(@$.begin.line);
                                                         $$->setAsParameter($1, $2);
                                                        }
                        ;

mainfunctiondeclaration : mainfunctiondeclarator block  {$$ = new AST(@$.begin.line);
                                                         $$->setAsMainFunction($1, $2);

                                                        }
                        ;

mainfunctiondeclarator  : identifier LB RB                  {$$ = new AST(@$.begin.line);
                                                             $$->setAsDeclarator($1);
                                                            }
                        ;

block                   : LCB blockstatements RCB           {$$ = new AST(@$.begin.line);
                                                             $$->setAsBlock($2);
                                                             if($2->hasSibling()){
                                                                AST* temp = $2;
                                                                while(temp->hasSibling()){
                                                                    temp = temp->getSibling();
                                                                    $$->addChild(temp);
                                                                }
                                                             }
                                                            }
                        | LCB RCB                           {$$ = new AST(@$.begin.line);
                                                             $$->setAsEmptyBlock();
                                                            }
                        ;

blockstatements         : blockstatement                    {$$ = $1;}
                        | blockstatements blockstatement    {$$ = $1;
                                                             AST *temp = $1;
                                                             while(temp->hasSibling()){
                                                                 temp = temp->getSibling();
                                                             }
                                                             temp->addSibling($2);
                                                            }
                        ;

blockstatement          : variabledeclaration       { //$$ = new AST(@$.begin.line);
                                                      //$$->setAsBlock($1);
                                                      $$ = $1;
                                                    }
                        | statement                 { //$$ = new AST(@$.begin.line);
                                                      //$$->setAsBlock($1);
                                                      $$ = $1;
                                                    }
                        ;

statement               : block                                         {$$ = $1;}
                        | SC                                            {$$ = new AST(@$.begin.line);
                                                                         $$->setAsNull();
                                                                        }
                        | statementexpression SC                        {$$ = $1;}
                        | BREAK SC                                      {$$ = new AST(@$.begin.line);
                                                                         $$->setAsBreak();
                                                                        }
                        | RET expression SC                             {$$ = new AST(@$.begin.line);
                                                                         $$->setAsReturn($2);
                                                                        }
                        | RET SC                                        {$$ = new AST(@$.begin.line);
                                                                         $$->setAsReturn();
                                                                        }
                        | IF LB expression RB statement                 {$$ = new AST(@$.begin.line);
                                                                         $$->setAsIf($3, $5);
                                                                        }
                        | IF LB expression RB statement ELSE statement  {$$ = new AST(@$.begin.line);
                                                                         $$->setAsIfElse($3, $5, $7);
                                                                        }
                        | WHILE LB expression RB statement              {$$ = new AST(@$.begin.line);
                                                                         $$->setAsWhile($3, $5);
                                                                        }
                        ;

statementexpression     : assignment                    {$$ = $1;
                                                        }
                        | functioninvocation            { $$ = $1;
                                                         // $$ = new AST(@$.begin.line);
                                                         // $$->setAsFunctionStatement($1);
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
                                                        }
                        ;

functioninvocation      : identifier LB argumentlist RB {$$ = new AST(@$.begin.line);
                                                         $$->setAsFunctionCall($1, $3); 
                                                         if($3->hasSibling()){
                                                            AST* temp = $3;
                                                            while(temp->hasSibling()){
                                                                temp = temp->getSibling();
                                                                $$->addChild(temp);
                                                            }
                                                        }
                                                        }
                        | identifier LB RB              {$$ = new AST(@$.begin.line);
                                                         $$->setAsFunctionCall($1);
                                                        }
                        ;

postfixexpression       : primary                   {$$ = $1;}
                        | identifier                {$$ = $1;}
                        ;

unaryexpression         : SUB unaryexpression       {$$ = new AST(@$.begin.line);
                                                     $$->setAsUnary(op_SUB, $2);
                                                    }
                        | NOT unaryexpression       {$$ = new AST(@$.begin.line);
                                                     $$->setAsUnary(op_NOT, $2);
                                                    }
                        | postfixexpression         {$$ = $1;}
                        ;

multiplicativeexpression: unaryexpression                       {$$ = $1;}
                        | multiplicativeexpression MULT unaryexpression     {$$ = new AST(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_MULT, $3);
                                                                            }
                        | multiplicativeexpression DIV unaryexpression      {$$ = new AST(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_DIV, $3);
                                                                            }
                        | multiplicativeexpression MOD unaryexpression      {$$ = new AST(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_MOD, $3);
                                                                            }
                        ;

additiveexpression      : multiplicativeexpression              {$$ = $1;}
                        | additiveexpression ADD multiplicativeexpression   {$$ = new AST(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_ADD, $3);
                                                                             
                                                                            }
                        | additiveexpression SUB multiplicativeexpression   {$$ = new AST(@$.begin.line);
                                                                             $$->setAsArithmetic($1, op_SUB, $3);
                                                                            }
                        ;

relationalexpression    : additiveexpression                    {$$ = $1;}    
                        | relationalexpression LT additiveexpression    {$$ = new AST(@$.begin.line);
                                                                         $$->setAsRelational($1, op_LT, $3);
                                                                        }
                        | relationalexpression GT additiveexpression    {$$ = new AST(@$.begin.line);
                                                                         $$->setAsRelational($1, op_GT, $3);
                                                                        }
                        | relationalexpression LE additiveexpression    {$$ = new AST(@$.begin.line);
                                                                         $$->setAsRelational($1, op_LE, $3);
                                                                        }
                        | relationalexpression GE additiveexpression    {$$ = new AST(@$.begin.line);
                                                                         $$->setAsRelational($1, op_GE, $3);
                                                                        }		
                        ;

equalityexpression      : relationalexpression                      {$$ = $1;}
                        | equalityexpression EQ relationalexpression		{$$ = new AST(@$.begin.line);
                                                                             $$->setAsEquality($1, op_EQ, $3);
                                                                            }
                        | equalityexpression NEQ relationalexpression		{$$ = new AST(@$.begin.line);
                                                                             $$->setAsEquality($1, op_NEQ, $3);
                                                                            }
                        ;

conditionalandexpression: equalityexpression                        {$$ = $1;}
                        | conditionalandexpression AND equalityexpression 	{$$ = new AST(@$.begin.line);
                                                                             $$->setAsConditional($1, op_AND, $3);	
                                                                            }
                        ;

conditionalorexpression : conditionalandexpression	{$$ = $1;}
                        | conditionalorexpression OR conditionalandexpression	{$$ = new AST(@$.begin.line);
                                                                                 $$->setAsConditional($1, op_OR, $3);
                                                                                }
                        ;

assignmentexpression    : conditionalorexpression                   {$$ = $1;}
                        | assignment			                    {$$ = $1;
                                                                     // $$ = new AST(@$.begin.line);
                                                                     // $$->setAsAssignment($1);
                                                                    }
                        ;

assignment              : identifier ASSIGN assignmentexpression {$$ = new AST(@$.begin.line); 
                                                                  $$->setAsAssignment($1, $3);
                                                                 }
                        ;

expression              : assignmentexpression                  {$$ = $1;}
                        ;
%%

void JCC::Parser::error(const location_type &loc, const std::string &errmsg)
{
   std::cerr << "Error: " << errmsg << " at line " << loc.begin.line << ", character " << loc.begin.column << "\n";
   driver.errorAtPos(loc.begin.line, loc.begin.column);
}
