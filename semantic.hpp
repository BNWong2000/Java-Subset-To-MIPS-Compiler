#pragma once

#ifndef SEMANTIC_HPP
#define SEMANTIC_HPP

#include "ast.hpp"
#include <unordered_map>
#include <string>

class Semantic
{
private:
    std::unordered_map<std::string, int> symbolTable;
    AST *root;

    // void preOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void postOrder(AST *curr, void (Semantic::*callback)(AST *));

    // void prePostOrder(AST *curr, void (Semantic::*preCall)(AST *), void (Semantic::*postCall)(AST *));

    void globalCheck_callback(AST *node);
    void pass2_callback(AST *node);

public:
    Semantic(){};
    ~Semantic(){};
    void setRoot(AST *myRoot){root = myRoot;};
    void checkTree();

    void checkGlobals();

};

#endif