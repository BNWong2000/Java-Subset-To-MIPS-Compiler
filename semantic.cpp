#include "semantic.hpp"

void Semantic::globalCheck_callback(AST *node){
    node->printWithoutChildren();
}

void Semantic::pass2_callback(AST *node) {}

void preOrder(AST *curr, void (Semantic::*callback)(AST*), Semantic *semantic){
    (semantic->*callback)(curr);
    for(int i = 0; i < curr->getChildren().size(); i++){
        preOrder(curr->getChildren()[i], callback, semantic);
    }
}

void postOrder(AST *curr, void (Semantic::*callback)(AST *), Semantic *semantic){
    for(int i = 0; i < curr->getChildren().size(); i++){
        postOrder(curr->getChildren()[i], callback, semantic);
    }
    (semantic->*callback)(curr);
}

void prePostOrder(AST *curr, void (Semantic::*preCall)(AST *), void (Semantic::*postCall)(AST *), Semantic *semantic){
    (semantic->*preCall)(curr);
    for(int i = 0; i < curr->getChildren().size(); i++){
        prePostOrder(curr->getChildren()[i], preCall, postCall, semantic);
    }
    (semantic->*postCall)(curr);
}

void Semantic::checkGlobals(){
    postOrder(root, &Semantic::globalCheck_callback, this);
}

void Semantic::checkTree(){
    std::cout << "checking globals\n" << std::endl;
    checkGlobals();
}