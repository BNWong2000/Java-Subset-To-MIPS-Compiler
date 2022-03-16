#include "semantic.hpp"

void Semantic::pass1_callback(AST *node)
{
    //
}

void Semantic::pass2_callback(AST *node) {}

void Semantic::preOrder(AST *curr, void (*callback)(AST*)){
    callback(curr);
    for(int i = 0; i < curr->getChildren().size(); i++){
        preOrder(curr->getChildren()[i], callback);
    }
}

void Semantic::postOrder(AST *curr, void (*callback)(AST *)){
    for(int i = 0; i < curr->getChildren().size(); i++){
        postOrder(curr->getChildren()[i], callback);
    }
    callback(curr);
}

void Semantic::prePostOrder(AST *curr, void (*preCall)(AST *), void (*postCall)(AST *)){
    preCall(curr);
    for(int i = 0; i < curr->getChildren().size(); i++){
        prePostOrder(curr->getChildren()[i], preCall, postCall);
    }
    postCall(curr);
}