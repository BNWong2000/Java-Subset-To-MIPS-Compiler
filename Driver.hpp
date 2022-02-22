#ifndef DRIVER_HPP
#define DRIVER_HPP

#include <string>
#include <memory>

#include "parser.hh"
#include "scanner.hpp"




class Driver
{
private:
    std::string fileName;

    std::unique_ptr<JCC::Parser> parser{nullptr};
    std::unique_ptr<JCC::MyLexer> lexer{nullptr};

public:
    Driver(const char *file) : fileName(file) {}
    ~Driver();

    int getToken(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location);
};

#endif