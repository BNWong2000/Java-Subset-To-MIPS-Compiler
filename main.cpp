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
    // char thing[256];
    // myStream->getline(thing, 256);

    // std::cout << thing << std::endl;

    auto lexer = createLexer(myStream);
    int tok;

    while ((tok = lexer->yylex()) != 0)
    {
        std::cout << " token " << std::endl;
    }

    if (myFile.is_open())
        myFile.close();

    return EXIT_SUCCESS;
}