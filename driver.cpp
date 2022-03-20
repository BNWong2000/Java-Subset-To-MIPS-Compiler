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
    if(token == JCC::Parser::token::T_ERR){
        std::cerr << " ERROR" << std::endl;
    }
    // std::cout << "lexing" << std::endl;
    if(token == JCC::Parser::token::T_WARN){
        std::cerr << " warning " << std::endl;
    }
    return token;
}

/**
 * @brief function to run the scanner and parser
 * 
 * @return int - exit status. 1 if error, 0 if no error.
 */
int Driver::start() {

    // Create an input stream and open the file  
    std::ifstream inputStream;
    inputStream.open(file_name);

    // Check that it opened properly
    if (!inputStream.is_open()){
        std::cerr << "ERROR: Failed to Open file: " << file_name << std::endl;
        return 1;
    }
    if (!(inputStream.good()) && inputStream.eof())
    {
        return 1;
    }

    // parse the file
    int rV = parse(inputStream);

    // close the file.
    inputStream.close();

    // if parsing didn't yield an error, then print the tree
    if (rV == 0) {
        // checker = new Semantic(tree);
        // std::cout << "checking tree..." << std::endl;
        // bool good = checker->checkTree();
        
        bool good = tree->checkSemantics();
        if(!good){
            std::cerr << "Semantic Error detected. Terminating..." << std::endl;
            return 1;
        }
        tree->print(0);
        
        
    } else {
        // otherwise, we print the error
        std::cerr << "\nLine: " << errorLine << " is shown below: " << std::endl;

        // re-open the file
        inputStream.open(file_name);
        if (!inputStream.is_open()){
            std::cerr << "ERROR: Failed to Open file: " << file_name << std::endl;
            return 1;
        }
        if (!(inputStream.good()) && inputStream.eof())
        {
            return 1;
        }

        // search for our erronious line
        int i = 1;
        std::string line;
        while(std::getline(inputStream, line) && i < errorLine){
            i++;
        }

        // Once we find it, print it
        std::cerr << line << std::endl;

        // put a marker at the character where the error occurs. 
        for(int i = 1; i < errorCol; i++){
            std::cerr << " ";
        }
        std::cerr << "^" << std::endl;
    }
    return rV;
}


/**
 * @brief Function to parse the file using the parser.
 * 
 * @param inputStream input stream of the file, for which we grab tokens
 * @return int exit status, 1 if error, 0 if success. 
 */
int Driver::parse(std::istream &inputStream) {

    // Create our parser and lexer
    lexer = createLexer(&inputStream);
    parser = std::make_unique<JCC::Parser>(*this);

    // call the parser to parse, and send the appropriate error message.
    if (parser->parse() != 0)
    {
        std::cerr << "Parse failed." << std::endl;
        return 1;
    }
    return 0;
}

