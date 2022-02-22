#include "driver.hpp"

Driver::Driver(){
    lexer.reset();
    parser.reset();
}


int Driver::getToken(JCC::Parser::semantic_type *yylval, JCC::Parser::location_type *location){
    int token = lexer->yylex(yylval, location);
    return token;
}
