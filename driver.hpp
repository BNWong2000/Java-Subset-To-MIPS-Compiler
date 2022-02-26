#pragma once
#ifndef DRIVER_HPP
#define DRIVER_HPP

#include <string>
#include <memory>
#include <istream>
#include "scanner.hpp"
#include "parser.hh"
#include "ast.hpp"

class Driver
{

public:
    Driver(const char* file) : file_name(file) { hasError = false;}
    ~Driver();
    int start();

    AST* tree = nullptr;

    std::string getFileName () { return file_name;}

    void errorAtPos(int line, int col){
        hasError = true; 
        errorLine = line;
        errorCol = col;
    };

    std::string getText(){
        std::string result (lexer->YYText());
        return result;
    };

    virtual int getToken(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location);

private:
    int parse(std::istream &inputStream);
    bool hasError;
    int errorLine;
    int errorCol;
    
    std::string file_name;
    std::unique_ptr<JCC::Parser> parser{nullptr};
    std::unique_ptr<JCC::MyLexer> lexer{nullptr};
};

#endif
