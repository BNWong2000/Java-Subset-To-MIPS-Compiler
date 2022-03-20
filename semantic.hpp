#pragma once

#ifndef SEMANTIC_HPP
#define SEMANTIC_HPP

#include <unordered_map>
#include <string>
#include <vector>
#include "ast.hpp"

class AST;

class SymEntry {
public:
    Variables type;
    std::vector<Variables> params;
    bool isFunc;

    SymEntry(){}
    SymEntry(Variables var){
        type = var;
    }

    void addParam(Variables var){
        params.push_back(var);
    }

    std::string getSig(){
        std::string result = "";
        
        if(isFunc){
            
            result += "f(";
            
            if(params.size() > 0){
                result += varToString(params[0]);
                for(int i = 1; i < params.size(); i++){
                    result += ", " + varToString(params[i]);
                }
            }
            result += ")";
        }else{
            return varToString(type);
        }
        return result;
    }

    std::string getRV(){
        return varToString(type);
    }

};

class Semantic {
private:
    // std::unordered_map<std::string, std::string> symbolTable;

    // Vector which stores all the symbol tables for each scope
    std::vector <std::unordered_map<std::string, SymEntry *>> tables;

    // Stack which is used to manage scope (contains index of symbols tables for each scope)
    // These are indices of 'tables' which are pushed and popped, from the stack
    // Using a vector instead of stack, since it allows me to iterate through it
    std::vector <int> scopeStack;
    AST *root;
    int depth;
    int currLoopCount;
    Variables funcRetType;
    bool returnSatisfied; 


    bool globalCheck_callback(AST *node);
    bool idCheckPre(AST *node);
    bool idCheckPost(AST *node);
    bool typeCheck(AST *node);
    bool miscCheckPre(AST *node);
    bool miscCheckPost(AST *node);

    // function for creating the symbol table for pre-defined functions (prints, etc)
    void createPreDef();

public:
    Semantic(AST *myRoot){
        createPreDef();
        std::unordered_map<std::string, SymEntry *> globalTable;
        tables.push_back(globalTable);
        scopeStack.push_back(1);
        depth = 2;
        currLoopCount = 0;
        root = myRoot;
        funcRetType = not_var;
        returnSatisfied = true;
    };
    ~Semantic(){};
    void setRoot(AST *myRoot){root = myRoot;};
    bool checkTree();

    bool checkGlobals();
    bool checkIds();
    bool checkTypes();
    bool checkMisc();

};

// No main declaration found. ***Done***
// Multiple main declarations found. ***Done (sorta)***
// A local declaration was not in an outermost block. ***Done***
// The number/type of arguments in a function call doesn't match the function's declaration. ***Done***
// The main function can't be called. ***Done***
// Break statements must be inside a while statement. ***Done***
// Type mismatch for an operator (||, &&, ==, !=, =, <, >, <=, >=, +, - (unary and binary), *, /, %, !). ***Done***
// No return statement in a non-void function. ***Done***
// A void function can't return a value. ***Done***
// A non-void function must return a value. ***Done***
// A value returned from a function has the wrong type. ***Done***
// An if- or while-condition must be of Boolean type. ***Done***
// An identifier is redefined within the same scope. ***Done***
// An undeclared identifier is used. ***Done***

#endif