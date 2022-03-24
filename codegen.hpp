#pragma once

#ifndef CODEGEN_HPP
#define CODEGEN_HPP

#include "ast.hpp"
#include <string>

class CodeGen{
private:
    AST *tree;
    std::string mainFuncName;

    // TODO: change this to output a file eventually. 
    void writeLine(std::string line){
        std::cout << line << std::endl;
    }
public:
    CodeGen(AST *theTree, std::string mainName){
        tree = theTree;
        mainFuncName = mainName;
    }

    bool globalsPass(AST *node);

    bool prePass(AST *node);

    bool postPass(AST *node);

    bool generate();

};


#endif