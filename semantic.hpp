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

    void preOrder(AST *curr, void (*callback)(AST *));

    void postOrder(AST *curr, void (*callback)(AST *));

    void prePostOrder(AST *curr, void (*preCall)(AST *), void (*postCall)(AST *));

    void pass1_callback(AST *node);
    void pass2_callback(AST *node);

public:
    void setRoot(AST *myRoot){root = myRoot;};

};

#endif