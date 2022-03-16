#include "semantic.hpp"

bool Semantic::globalCheck_callback(AST *node){
    if(node->theNode == declaration){
        switch(node->theDeclType){
            case mainFunction: {

                // Check if the main function has previously been declared. 
                std::cout << "main function" << std::endl;
                std::string name = node->getChildren()[0]->getChildren()[0]->getName();
                
                if(symbolTable.find(name) != symbolTable.end()){
                    std::cerr << "main function already exists!" << std::endl;
                    return false;
                }
                symbolTable.insert({name, "exists"});
                break;
            }
            case function: {
                std::cout << "function" << std::endl;
                AST *funcDecl = node->getChildren()[0]->getChildren()[0];
                std::string name = funcDecl->getChildren()[0]->getName();
                std::cout << name << std::endl;
                if(symbolTable.find(name) != symbolTable.end()){
                    std::cerr << "Duplicate function of name \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                std::string entry = "f(";
                if(funcDecl->getChildren().size() > 1){
                    entry += varToString(funcDecl->getChildren()[1]->getTheVar());
                    for(int i = 2; i < funcDecl->getChildren().size(); i++){
                        entry += ", " + varToString(funcDecl->getChildren()[i]->getTheVar());
                    }
                }
                entry += ")";
                std::cout << entry << std::endl;
                symbolTable.insert({name, entry});
                break;
            }
            case globalVariable: {
                std::cout << "global var" << std::endl;
                std::string name = node->getChildren()[0]->getName();
                if(symbolTable.find(name) != symbolTable.end()){
                    std::cerr << "Duplicate global variable \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                std::string entry = varToString(node->getTheVar());
                std::cout << name << " is a(n) " << entry << std::endl;
                symbolTable.insert({name, entry});
                break;
            }
            default:
                ;
        }
    }
    return true;
    // node->printWithoutChildren();
}

void Semantic::pass2_callback(AST *node) {}

bool preOrder(AST *curr, bool (Semantic::*callback)(AST*), Semantic *semantic){
    if(!(semantic->*callback)(curr)){
        return false;
    }
    for(int i = 0; i < curr->getChildren().size(); i++){
        if(!preOrder(curr->getChildren()[i], callback, semantic)){
            return false;
        }
    }
    return true;
}

bool postOrder(AST *curr, bool (Semantic::*callback)(AST *), Semantic *semantic){
    for(int i = 0; i < curr->getChildren().size(); i++){
        if(!postOrder(curr->getChildren()[i], callback, semantic)){
            return false;
        }
    }
    if(!(semantic->*callback)(curr)){
        return false;
    }
    return true;
}

bool prePostOrder(AST *curr, bool (Semantic::*preCall)(AST *), bool (Semantic::*postCall)(AST *), Semantic *semantic){
    if(!(semantic->*preCall)(curr)){
        return false;
    }
    for(int i = 0; i < curr->getChildren().size(); i++){
        if(!prePostOrder(curr->getChildren()[i], preCall, postCall, semantic)){
            return false;
        }
    }
    if(!(semantic->*postCall)(curr)){
        return false;
    }
    return true;
}

bool Semantic::checkGlobals(){
    if(!postOrder(root, &Semantic::globalCheck_callback, this)){
        return false;
    };
    if(symbolTable.find("main") == symbolTable.end()){
        std::cerr << "ERROR: no main function found" << std::endl;
        return false;
    }
    return true;
}

bool Semantic::checkTree(){
    std::cout << "checking globals\n" << std::endl;
    if(!checkGlobals()){
        return false;
    }
    return true;
}