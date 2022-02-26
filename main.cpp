#include <cstdlib>
#include <cerrno>
#include <cstring>
#include <iostream>
// #include <FlexLexer.h>

// #include "scanner.hpp"
#include "driver.hpp"

/**
 * The max number of warnings before the program closes.
 */
#define MAXNUMWARNINGS 10

int main(int argc, char *argv[])
{
    std::ifstream myFile;
    Driver *myDriver;

    // First, check that an argument for the file can exist
    if (argc < 2)
    {
        std::cerr << "ERROR: No file Specified. " << std::endl;
        return EXIT_FAILURE;
        // attempt to open the file name argument
    }

    
    myDriver = new Driver(argv[1]);

    
    int rV = myDriver->start();
    return rV;

}
