#pragma once

#ifndef SEMANTIC_HPP
#define SEMANTIC_HPP

#include "ast.hpp"
#include <unordered_map>
#include <string>
#include <deque>
#include <vector>

class symEntry {
public:
    Variables type;
    std::vector<Variables> params;
    
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

    // void preOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void postOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void prePostOrder(AST *curr, void (Semantic::*preCall)(AST *), void (Semantic::*postCall)(AST *));

    bool globalCheck_callback(AST *node);
    bool idCheckPre(AST *node);
    bool idCheckPost(AST *node);
    bool typeCheck(AST *node);

public:
    Semantic(AST *myRoot){
        std::unordered_map<std::string, symEntry *> globalTable;
        tables.push_back(globalTable);
        scopeStack.push_back(0);
        depth = 1;
        root = myRoot;
    };
    ~Semantic(){};
    void setRoot(AST *myRoot){root = myRoot;};
    bool checkTree();

    bool checkGlobals();
    bool checkIds();
    bool checkTypes();

};

// No main declaration found. ***Done***
// Multiple main declarations found. ***Done (sorta)***
// A local declaration was not in an outermost block. ***Done***
// The number/type of arguments in a function call doesn't match the function's declaration.
// The main function can't be called. 
// Break statements must be inside a while statement.
// Type mismatch for an operator (||, &&, ==, !=, =, <, >, <=, >=, +, - (unary and binary), *, /, %, !).
// No return statement in a non-void function.
// A void function can't return a value.
// A non-void function must return a value. Note that you're only checking for the existence of an appropriate return statement at the semantic checking stage, not whether it's actually executed.
// A value returned from a function has the wrong type.
// An if- or while-condition must be of Boolean type.
// An identifier is redefined within the same scope. ***Done***
// An undeclared identifier is used. ***Done***

#endif