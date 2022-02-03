#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <iostream>
#include <FlexLexer.h>

#include "main.hpp"
#define MAXNUMWARNINGS 10
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
    int warningCount = 0;
    while ((tok = lexer->yylex()) != 0)
    {
        std::cout << "line: " << lexer->getLine() << " token " << getName(tok);
        if(tok == T_ERR){
            return EXIT_FAILURE;
        }

        if(tok == T_STR){
            std::cout << " Lexeme: ";
            const char *temp = lexer->YYText();  
            int size = lexer->YYLeng();
            for(int i = 0; i < size; ++i){
                std::cout << temp[i];
            }
            std::cout << std::endl;
        }else if (tok == T_ID || tok == T_NUM){
            std::cout << " Lexeme: " << lexer->getLexeme() << "\n";
        }else if (tok == T_WARN){
            int lineNum = lexer->getLine();
            std::cerr << "WARNING: Ignoring an illegal char on line " << lineNum << std::endl;
            warningCount++;
            if(warningCount == MAXNUMWARNINGS){
                std::cerr << "ERROR: Too many illegal characters at or near line " << lineNum << std::endl;
                return EXIT_FAILURE;
            }
            
        }else{
            std::cout << "\n";
        }
                  
    }

    if (myFile.is_open())
        myFile.close();
    return EXIT_SUCCESS;
}