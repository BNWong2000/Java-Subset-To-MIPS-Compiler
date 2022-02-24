%option c++
%option yyclass="JCC::MyLexer"
%option yylineno 
%option noyywrap

%{
    // Declarations
    #include <iostream>
    #include <fstream>
    #include "scanner.hpp"
    #include "parser.hh"

    using Token = JCC::Parser::token;

    #undef  YY_DECL
    #define YY_DECL int JCC::MyLexer::yylex(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location)
    #define YY_USER_ACTION location->step(); location->columns(yyleng);
%}

/* Definitions: */

alpha [a-zA-Z]
alphaUnderscore [a-zA-Z_]
alphaNumUnderscore [0-9a-zA-Z_]
digit [0-9]
alphaNum [0-9a-zA-Z]

num {digit}{digit}*

/* Since ID's can contain _, then we include them in the regex*/
ID {alphaUnderscore}{alphaNumUnderscore}*

%x COMMENT
%x STRING

%%
[ \t\r]+    ;  /* Whitespace*/
\n        location->lines(); location->step();


">"         return Token::T_GT; /* All known reserved words and symbols */
"<"         return Token::T_LT;
">="        return Token::T_GE;
"<="        return Token::T_LE;
"+"         return Token::T_ADD;
"-"         return Token::T_SUB;
"/"         return Token::T_DIV;
"*"         return Token::T_MULT;
"%"         return Token::T_MOD;
"="         return Token::T_ASSIGN;
"=="        return Token::T_EQ;
"!="        return Token::T_NEQ;
"!"         return Token::T_NOT;
"&&"        return Token::T_AND;
"||"        return Token::T_OR;
"if"        return Token::T_IF;
"else"      return Token::T_ELSE;
"while"     return Token::T_WHILE;
"break"     return Token::T_BREAK;
"return"    return Token::T_RET;
"("         return Token::T_LB;
")"         return Token::T_RB;
"{"         return Token::T_LCB;
"}"         return Token::T_RCB;
";"         return Token::T_SC;
","         return Token::T_COM;
"true"      return Token::T_TRUE;
"false"     return Token::T_FALSE;
"boolean"   return Token::T_BOOL;
"int"       return Token::T_INT;
"void"      return Token::T_VOID;

{ID}        {yylval->str = new std::string(yytext); return Token::T_ID;}
{num}       {yylval->ival = std::stoi(yytext); return Token::T_NUM;}

"//"            BEGIN(COMMENT);
\"              {yymore(); BEGIN(STRING); }


<STRING>\"          {BEGIN(INITIAL); yylval->str = new std::string(yytext); return Token::T_STR;}     /* Strings */
<STRING>"\\\""      { yymore();}                        /* If a \" is inside of a string, then include it. */
<STRING>\n          {std::cerr << "ERROR: Newline inside string." << std::endl; return Token::T_ERR;}  /* Check for EOF or newline in strings */
<STRING><<EOF>>     {std::cerr << "ERROR: Unterminated String." << std::endl; return Token::T_ERR;}
<STRING>.           { yymore();}

<COMMENT>.
<COMMENT>\n     {location->lines(); location->step(); BEGIN(INITIAL); }


.               {return T_WARN;} /* Send warning on illegal character */
%%

/* This code was obtained from the TA (Shankar) in tutorial.*/
std::unique_ptr<JCC::MyLexer> createLexer(std::istream* inputStream) {
    return std::make_unique<JCC::MyLexer>(inputStream);
}
