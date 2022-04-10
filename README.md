# CPSC-411-Project
Branden Wong - 30040675

## How to Build:
### Prerequisites:
- Ensure that your computer is running c++14 and contains the clang++ compiler
- Ensure that the Fast Lexical Analyzer Tool (FLEX) libary is installed on your computer. This can be found here: [FLEX](https://github.com/westes/flex)).
- Ensure that the Bison libary is installed on your computer. This can be found here: [Bison](https://www.gnu.org/software/bison/)).

### Build Instructions:
1. Clone this repository, and navigate to the base folder, `cpsc-411-project`
2. execute `make` in the console within this directory. This will generate an executable named `main`.

### Execution Instructions:
1. After bulding the project, the main executable should be created. 
2. Execute this file and include the file you would like to compile as an argument. Example:
`./main [NAME_OF_FILE]`

This will output the MIPS assembly code to standard output, which can then be piped to a *.s file. 

Example:
`./main /path/to/j--/file > outputFileName.s`

### Example test File Outputs:
 - The outputs of the provided test files (located in the cpsc folder ~Aycock/411/TEST/final/) are found in the finalResults folder. 
    - These include the assembly files (denoted with a .s) and the output of said files, when run with SPIM (denoted with a .out)


