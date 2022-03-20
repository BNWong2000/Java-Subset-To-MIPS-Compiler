#pragma once

#ifndef SEMANTIC_HPP
#define SEMANTIC_HPP

#include "ast.hpp"
#include <unordered_map>
#include <string>
#include <vector>

class symEntry {
public:
    Variables type;
    std::vector<Variables> params;
    bool isFunc;

    symEntry(){}
    symEntry(Variables var){
        type = var;
    }

    void addParam(Variables var){
        params.push_back(var);
    }

};

class Semantic {
private:
    // std::unordered_map<std::string, std::string> symbolTable;

    // Vector which stores all the symbol tables for each scope
    std::vector <std::unordered_map<std::string, symEntry *>> tables;

    // Stack which is used to manage scope (contains index of symbols tables for each scope)
    // These are indices of 'tables' which are pushed and popped, from the stack
    // Using a vector instead of stack, since it allows me to iterate through it
    std::vector <int> scopeStack;
    AST *root;
    int depth;
    int currLoopCount;
    Variables funcRetType;
    bool returnSatisfied; 

    // void preOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void postOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void prePostOrder(AST *curr, void (Semantic::*preCall)(AST *), void (Semantic::*postCall)(AST *));

    bool globalCheck_callback(AST *node);
    bool idCheckPre(AST *node);
    bool idCheckPost(AST *node);
    bool typeCheck(AST *node);
    bool miscCheckPre(AST *node);
    bool miscCheckPost(AST *node);

public:
    Semantic(AST *myRoot){
        std::unordered_map<std::string, symEntry *> globalTable;
        tables.push_back(globalTable);
        scopeStack.push_back(0);
        depth = 1;
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