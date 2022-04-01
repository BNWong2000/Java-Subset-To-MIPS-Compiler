#pragma once

#ifndef CODEGEN_HPP
#define CODEGEN_HPP

#include "ast.hpp"
#include <string>
#include <utility>
#include "regEnums.hpp"
#include "headerFuncCode.hpp"

class CodeGen{
private:
    AST *tree;
    std::string mainFuncName;

    // TODO: change this to output a file eventually. 
    void writeLine(std::string line){
        std::cout << line << std::endl;
    }

    // Same as above, but adds a tab.
    void writeTabbedLine(std::string line){
        std::cout << "\t" << line << std::endl;
    }

    int stackLevel;
    int currParamCount;
    int currWhileCount;
    int currIfCount;
    int initFuncStack;

    int storeOnStack(){
        // int rV = stackLevel;
        stackLevel += 4;
        return stackLevel;
    }

    void popFromStack(){
        stackLevel -= 4;
    }

    void initRegList();

    Registers getNextReg(){
        for(int i = 0; i < regList.size(); i++){
            if(regList[i].first != NONE && regList[i].second){
                regList[i].second = false;
                return regList[i].first;
            }
        }
        return NONE;
    }

    void freeReg(Registers reg){
        // just iterate through and search. Can't do binary search :/
        for(int i = 0; i < regList.size(); i++){
            if(regList[i].first == reg){
                regList[i].second = true;
                return;
            }
        }
    }

    void claimReg(Registers reg){
        // just iterate through and search. Can't do binary search :/
        for(int i = 0; i < regList.size(); i++){
            if(regList[i].first == reg){
                regList[i].second = false;
                return;
            }
        }
    }
    // could use a map here, but there are so few registers, that searching in a vector is fine. 
    // Also, iterating through a vector is a little simpler. 
    std::vector <std::pair<Registers, bool>> regList; // if second is false, it's not available.
    std::vector<std::pair<Registers, int>> storeCurrRegisters();
    void restoreRegisters(std::vector<std::pair<Registers, int>> regs);
    void generateHeaderFuncs();
public:
    CodeGen(AST *theTree, std::string mainName){
        tree = theTree;
        mainFuncName = mainName;
        stackLevel = 0;
        currWhileCount = -1;
        currIfCount = -1;
        initRegList();
    }

    bool globalsPass(AST *node);

    bool prePass(AST *node);

    bool postPass(AST *node);

    bool generate();

};

inline std::string opToInstr(Operators op){
    switch (op){
        case op_ADD:    return "addu";
        case op_SUB:    return "subu";
        case op_MULT:   return "mul";
        case op_DIV:    return "divu";
        case op_MOD:    return "remu";
        case op_LT:     return "slt";
        case op_GT:     return "sgt";
        case op_GE:     return "sge";
        case op_LE:     return "sle";
        case op_EQ:     return "seq";
        case op_NEQ:    return "sne";
        case op_NOT:    return "!";
        case op_AND:    return "and";
        case op_OR:     return "os";
        default: return "invalid op.";
    }
}


#endif