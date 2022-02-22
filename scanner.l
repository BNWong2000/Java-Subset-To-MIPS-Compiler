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
    #define YY_USER_ACTION location->step();
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
\n        ;


">"         return T_GT; /* All known reserved words and symbols */
"<"         return T_LT;
">="        return T_GE;
"<="        return T_LE;
"+"         return T_ADD;
"-"         return T_SUB;
"/"         return T_DIV;
"*"         return T_MULT;
"%"         return T_MOD;
"="         return T_ASSIGN;
"=="        return T_EQ;
"!="        return T_NEQ;
"!"         return T_NOT;
"&&"        return T_AND;
"||"        return T_OR;
"if"        return T_IF;
"else"      return T_ELSE;
"while"     return T_WHILE;
"break"     return T_BREAK;
"return"    return T_RET;
"("         return T_LB;
")"         return T_RB;
"{"         return T_LCB;
"}"         return T_RCB;
";"         return T_SC;
","         return T_COM;
"true"      return T_TRUE;
"false"     return T_FALSE;
"boolean"   return T_BOOL;
"int"       return T_INT;
"void"      return T_VOID;

{ID}        {lexeme = std::string(YYText()); return T_ID;}
{num}       {lexeme = std::string(YYText()); return T_NUM;}

"//"            BEGIN(COMMENT);
\"              {yymore(); BEGIN(STRING); }


<STRING>\"          {BEGIN(INITIAL); return T_STR;}     /* Strings */
<STRING>"\\\""      { yymore();}                        /* If a \" is inside of a string, then include it. */
<STRING>\n          {std::cerr << "ERROR: Newline inside string." << std::endl; return T_ERR;}  /* Check for EOF or newline in strings */
<STRING><<EOF>>     {std::cerr << "ERROR: Unterminated String." << std::endl; return T_ERR;}
<STRING>.           { yymore();}

<COMMENT>.
<COMMENT>\n     {BEGIN(INITIAL); }


.               {return T_WARN;} /* Send warning on illegal character */
%%

/* This code was obtained from the TA (Shankar) in tutorial.*/
std::unique_ptr<JCC::MyLexer> createLexer(std::istream* inputStream) {
    return std::make_unique<JCC::MyLexer>(inputStream);
}
