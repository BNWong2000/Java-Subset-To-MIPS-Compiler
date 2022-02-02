#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <iostream>
#include <FlexLexer.h>

#include "main.hpp"

int main(int argc, char* argv[]){
    std::ifstream myFile;

    if(argc >= 2){
        myFile.open(argv[1]);
        if(!myFile.is_open()){
            std::cerr << "ERROR: Failed to Open file: " << argv[1] << std::endl;
            return EXIT_FAILURE;
        }
    }else{
        std::cerr << "ERROR: No file Specified. " << std::endl;
        return EXIT_FAILURE;
    }

    std::istream *myStream = &myFile;

    auto lexer = createLexer(myStream);
    int tok;

    while ((tok = lexer->yylex()) != 0)
    {
        std::cout << "line: " << lexer->getLine() << " token " << getName(tok) << " Lexeme: |" << lexer->YYText() << "|\n";
        
        // if (tok == T_ID || tok == T_NUM){
        //     std::cout << " Lexeme: " << lexer->getLexeme() << "\n";
        // }else{
        //     std::cout << "\n";
        // }
                  
    }

    if (myFile.is_open())
        myFile.close();
    return EXIT_SUCCESS;
}