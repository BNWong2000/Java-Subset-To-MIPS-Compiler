%option c++
%option yyclass="myLexer"
%option yylineno 
%option noyywrap

%{
    // Declarations
    #include <iostream>
    #include <fstream>
    #include "main.hpp"
%}

/* Definitions: */

alpha [a-zA-Z]
digit [0-9]
alphaNum [0-9a-zA-Z]


num {digit}{digit}*
ID {alpha}{alphaNum}*

%x COMMENT

%%
[ \t\r]+    ;  /* Whitespace*/
\n          ;

">"         return T_GT;
"<"         return T_LT;
">="        return T_GE;
"<="        return T_LE;
"+"         return T_ADD;
"-"         return T_SUB;
"/"         return T_DIV;
"*"         return T_MULT;
"if"        return T_IF;
"else"      return T_ELSE;
"begin"     return T_BEGIN;
"end"       return T_END;

{ID}        {lexeme = std::string(YYText()); return T_ID;}
{num}       return T_NUM;

"#"             BEGIN(COMMENT);
<COMMENT>.
<COMMENT>\n     {BEGIN(INITIAL); std::cout << "Comment on line " << yylineno << "\n"; }

.           std::cerr << "Illegal char on line " << yylineno << std::endl;
%%

std::unique_ptr<myLexer> createLexer(std::istream* inputStream) {
    return std::make_unique<myLexer>(inputStream);
}