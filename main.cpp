#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <iostream>
#include <FlexLexer.h>

#include "main.hpp"

/** 
 * The max number of warnings before the program closes. 
*/
#define MAXNUMWARNINGS 10


int main(int argc, char* argv[]){
    std::ifstream myFile;

    // First, check that an argument for the file can exist
    if(argc >= 2){

        // attempt to open the file name argument
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

    // Create the Lexer.
    auto lexer = createLexer(myStream);
    int tok;
    int warningCount = 0;

    // Loop using the lexer, until we reach the end of the file
    while ((tok = lexer->yylex()) != 0){   
        // Print out the token.
        std::cout << "line: " << lexer->getLine() << " token " << getName(tok);

        // Check if we recieved an error token, upon which we end the program.
        if(tok == T_ERR){
            if (myFile.is_open())
                myFile.close();
            return EXIT_FAILURE;
        }

        // Check if the token is a string
        if(tok == T_STR){
            std::cout << " Lexeme: ";

            // Get the raw char array
            const char *temp = lexer->YYText();  
            int size = lexer->YYLeng();

            // Iterate through the char array, and print each character individually.
            // This takes care of the case where there is a null character in the middle of the string.
            for(int i = 0; i < size; ++i){
                std::cout << temp[i];
            }
            std::cout << std::endl;

        // Check if the token is an ID or number. if it is, we print out the lexeme.
        }else if (tok == T_ID || tok == T_NUM){
            std::cout << " Lexeme: " << lexer->getLexeme() << "\n";

        // Check if the token sent a warning signal.
        }else if (tok == T_WARN){
            int lineNum = lexer->getLine();
            // Print out the warning.
            std::cerr << "WARNING: Ignoring an illegal char on line " << lineNum << std::endl;

            // Incremember the warning count.
            warningCount++;

            // if we exceed the maximum number of warnings set, then exit the program with an error. 
            if(warningCount == MAXNUMWARNINGS){
                std::cerr << "ERROR: Too many illegal characters at or near line " << lineNum << std::endl;
                if (myFile.is_open())
                    myFile.close();
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
