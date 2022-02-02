#ifndef MAIN_HPP
#define MAIN_HPP

#include <iostream>
#include <fstream>
#include <memory>


#include <cstdlib>
#include <cerrno>
#include <cstring>
// Token enum
enum
{
    T_ID = 1,
    T_BEGIN,
    T_END,
    T_NUM,
    T_ADD,
    T_SUB,
    T_DIV,
    T_MULT,
    T_MOD,
    T_LT,
    T_GT,
    T_GE,
    T_LE,
    T_EQ,
    T_BEQ,
    T_NEQ,
    T_NOT,
    T_AND,
    T_OR,
    T_IF,
    T_ELSE,
    T_STR
};

class myLexer : public yyFlexLexer
{

public:
    myLexer(std::istream *inputStream) : yyFlexLexer(inputStream) {
        yylineno=1;
    }

    virtual ~myLexer() = default;

    int yylex();

    int getLine() { return yylineno; }

    std::string getLexeme(){
        return lexeme;
    }

    std::string lexeme;
};

std::unique_ptr<myLexer> createLexer(std::istream *inputStream);

inline char const* getName(int token){
    switch(token){
        case T_ID:
            return "ID";
        case T_BEGIN:
            return "BEGIN";
        case T_END:
            return "END";
        case T_NUM:
            return "NUMBER";
        case T_ADD:
            return "+";
        case T_SUB:
            return "-";
        case T_DIV:
            return "/";
        case T_MULT:
            return "*";
        case T_LT:
            return "<";
        case T_GT:
            return ">";
        case T_GE:
            return ">=";
        case T_LE:
            return "<=";
        case T_EQ:
            return "=";
        case T_BEQ:
            return "==";
        case T_NEQ:
            return "!=";
        case T_NOT:
            return "!";
        case T_AND:
            return "&&";
        case T_OR:
            return "||";
        case T_IF: 
            return "IF";
        case T_ELSE:
            return "ELSE";
        case T_STR:
            return "STRING";
        default:
            return "";
    }
}

#endif