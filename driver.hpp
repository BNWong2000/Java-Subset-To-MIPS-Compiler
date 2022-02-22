#pragma once
#ifndef DRIVER_HPP
#define DRIVER_HPP

#include <string>
#include <memory>
#include "scanner.hpp"
#include "parser.hh"

class Driver
{


public:
    Driver(const char *file) : fileName(file) {}
    ~Driver();

    virtual int getToken(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location);

private:
    std::string fileName;

    std::unique_ptr<JCC::Parser> parser{nullptr};
    std::unique_ptr<JCC::MyLexer> lexer{nullptr};
};

#endif
