#pragma once
#ifndef SCANNER_HPP
#define SCANNER_HPP

#include <iostream>
#include <fstream>
#include <memory>

#include <cstdlib>
#include <cerrno>
#include <cstring>


#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.hh"
#include "location.hh"

// Token enum
enum
{
    T_ID = 1,
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
    T_ASSIGN,
    T_EQ,
    T_NEQ,
    T_NOT,
    T_AND,
    T_OR,
    T_IF,
    T_ELSE,
    T_WHILE,
    T_BREAK,
    T_RET,
    T_STR,
    T_LB,
    T_RB,
    T_RCB,
    T_LCB,
    T_SC,
    T_COM,
    T_TRUE,
    T_FALSE,
    T_BOOL,
    T_INT,
    T_VOID,
    T_WARN,
    T_ERR
};

/**
 * A class which inherits the yyFlexLexer class from FLex
 * The purpose of this is to lex the input file, and return the necessary information
 * to generate a token.
 */
namespace JCC
{
    class MyLexer : public yyFlexLexer
    {

    public:
        MyLexer(std::istream *inputStream) : yyFlexLexer(inputStream)
        {
        }

        virtual ~MyLexer() = default;

        virtual int yylex(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location);

        // int getLine() { return yylineno; }

        std::string getLexeme()
        {
            return lexeme;
        }

        std::string lexeme;
    };
}

std::unique_ptr<JCC::MyLexer> createLexer(std::istream *inputStream);

/**
 * @brief Gets the name given the token type.
 * Based off of code from the TA shown in tutorial.
 * @param token the enumerated value of the token.
 * @return char const* - the string format name to be printed with the token information.
 */
inline char const *getName(int token)
{
    switch (token)
    {
    case T_ID:
        return "ID";
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
    case T_MOD:
        return "%";
    case T_LT:
        return "<";
    case T_GT:
        return ">";
    case T_GE:
        return ">=";
    case T_LE:
        return "<=";
    case T_ASSIGN:
        return "=";
    case T_EQ:
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
        return "if";
    case T_ELSE:
        return "else";
    case T_WHILE:
        return "while";
    case T_BREAK:
        return "break";
    case T_RET:
        return "return";
    case T_STR:
        return "STRING";
    case T_LB:
        return "(";
    case T_RB:
        return ")";
    case T_LCB:
        return "{";
    case T_RCB:
        return "}";
    case T_SC:
        return ";";
    case T_COM:
        return ",";
    case T_TRUE:
        return "true";
    case T_FALSE:
        return "false";
    case T_BOOL:
        return "boolean";
    case T_INT:
        return "int";
    case T_VOID:
        return "void";
    default:
        return "";
    }
}

#endif
