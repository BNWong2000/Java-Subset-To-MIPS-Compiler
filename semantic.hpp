#pragma once

#ifndef SEMANTIC_HPP
#define SEMANTIC_HPP

#include "ast.hpp"
#include <unordered_map>
#include <string>
#include <deque>
#include <vector>

class Semantic
{
private:
    // std::unordered_map<std::string, std::string> symbolTable;

    // Vector which stores all the symbol tables for each scope
    std::vector <std::unordered_map<std::string, std::string>> tables;

    // Stack which is used to manage stack (contains symbols tables for each scope)
    // These are references which are pushed and popped, from the stack, but retained in the tables vector
    // Using a vector instead of stack, since it allows me to iterate through
    std::vector <int> scopeStack;
    AST *root;

    // void preOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void postOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void prePostOrder(AST *curr, void (Semantic::*preCall)(AST *), void (Semantic::*postCall)(AST *));

    bool globalCheck_callback(AST *node);
    bool idCheckPre(AST *node);
    bool idCheckPost(AST *node);

public:
    Semantic(AST *myRoot){
        std::unordered_map<std::string, std::string> globalTable;
        tables.push_back(globalTable);
        scopeStack.push_back(0);
        root = myRoot;
    };
    ~Semantic(){};
    void setRoot(AST *myRoot){root = myRoot;};
    bool checkTree();

    bool checkGlobals();
    bool checkIds();

};

#endif