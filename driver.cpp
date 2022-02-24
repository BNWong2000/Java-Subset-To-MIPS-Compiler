#include <fstream>
#include "driver.hpp"




Driver::~Driver()
{
    lexer.reset();
    parser.reset();
}

int Driver::getToken(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location)
{
    int token = lexer->yylex(yylval, location);
    return token;
}


int Driver::start(std::istream &inputStream)
{
    if (!(inputStream.good()) && inputStream.eof())
    {
        return 1;
    }
    int rV = parse(inputStream);

    if (rV == 0)
    {
        tree->print(0);
    }
    return rV;
}



int Driver::parse(std::istream &inputStream)
{
    lexer = createLexer(&inputStream);

    parser = std::make_unique<JCC::Parser>(*this);

    if (parser->parse() != 0)
    {
        std::cerr << "Parse failed." << std::endl;
        return 1;
    }
    return 0;
}

