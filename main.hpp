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
    T_LT,
    T_GT,
    T_GE,
    T_LE,
    T_IF,
    T_ELSE,
};

class myLexer : public yyFlexLexer
{

public:
    myLexer(std::istream *inputStream) : yyFlexLexer(inputStream) {
        yylineno=1;
    }

    virtual ~myLexer() = default;

    int yylex();

    std::string lexeme;
};

std::unique_ptr<myLexer> createLexer(std::istream *inputStream);

#endif