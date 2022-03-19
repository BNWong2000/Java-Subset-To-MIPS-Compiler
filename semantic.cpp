#include "semantic.hpp"



bool Semantic::globalCheck_callback(AST *node){
    if(node->theNode == declaration){
        
        switch(node->theDeclType){
            case mainFunction: {

                // Check if the main function has previously been declared. 
                std::cout << "main function" << std::endl;
                std::string name = node->getChildren()[0]->getChildren()[0]->getName();
                
                if(tables[0].find(name) != tables[0].end()){
                    std::cerr << "main function already exists!" << std::endl;
                    return false;
                }
                tables[0].insert({name, "exists"});
                break;
            }
            case function: {
                std::cout << "function" << std::endl;
                AST *funcDecl = node->getChildren()[0]->getChildren()[0];
                std::string name = funcDecl->getChildren()[0]->getName();
                std::cout << name << std::endl;
                if(tables[0].find(name) != tables[0].end()){
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
                tables[0].insert({name, entry});
                break;
            }
            case globalVariable: {
                std::cout << "global var" << std::endl;
                std::string name = node->getChildren()[0]->getName();
                if(tables[0].find(name) != tables[0].end()){
                    std::cerr << "Duplicate global variable \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                std::string entry = varToString(node->getTheVar());
                std::cout << name << " is a(n) " << entry << std::endl;
                tables[0].insert({name, entry});
                break;
            }
            default:
                ;
        }
    }
    return true;
    // node->printWithoutChildren();
}

/**
 * Pseudo pseudo-code plan:
 * check if main or regular function. 
 *      if so, make new hash and push to stack (and to the tables vector)
 * if not, then if it's an ID, do appropriate checks
 *      if it's a declaration, check if it's already in current scope
 *          if it isn't, in current scope, then add it.
 *          if it is, then error. 
 *      if it's a func call or variable, iterate through the stack and check. 
 *          if exists, point to it.
 *          if not, error.
 * Ignore everything else.
 */
bool Semantic::idCheckPre(AST *node){
    // check for block. if there is one, push onto stack. 
    // if it's not a stack, check for vars and add them onto symbol table for top of stack.
    if(node->theNode == declaration && node->theDeclType == function){
        // function or main declaration (both have declarator children)
        std::unordered_map<std::string, std::string> currScope;
        scopeStack.push_back(tables.size());
        tables.push_back(currScope); 
    }else if(node->theNode == declaration){
        if(node->theDeclType == variable || node->theDeclType == parameter){
            std::string name = node->getFirstChild()->getName();
            // variable
            std::unordered_map<std::string, std::string> &top = tables[scopeStack.back()];
            if(top.find(name) == top.end()){ 
                // not inside of the top scope
                top.insert({name, varToString(node->getTheVar())});
            }else{
                // error
                std::cerr <<"Line: " << node->getLine() << " Error: an Identifier with name \"" << name << "\" already exists in this scope. " << std::endl;
                return false;
            }
        }
    }else if(node->theNode == expression && node->theExprType == identifier){
        // any identifier
        bool found = false;
        std::string name = node->getName();
        // iterate through stack from top down
    
        for(int i = scopeStack.size()-1; i >= 0; i--){
            int currInd = scopeStack[i];
            if(tables[currInd].find(name) != tables[currInd].end()){
                found = true;
                break;
            }
            
        }

        if(!found){
            std::cerr <<"Line: " << node->getLine() << " Error: identifier \"" << name << "\" has not yet been declared. " << std::endl;
            return false;
        }

    }
    // otherwise ignore them. 
    return true;
}

bool Semantic::idCheckPost(AST *node){
    // pop from stack.
    if(node->theNode == declaration && node->theDeclType == function){
        scopeStack.pop_back();
    }
    return true;
}

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
    }
    if(tables[0].find("main") == tables[0].end()){
        std::cerr << "ERROR: no main function found" << std::endl;
        return false;
    }
    return true;
}

bool Semantic::checkIds(){
    if(!prePostOrder(root, &Semantic::idCheckPre, &Semantic::idCheckPost, this)){
        return false;
    }
    return true;
}

bool Semantic::checkTree(){
    std::cout << "checking globals..." << std::endl;
    if(!checkGlobals()){
        return false;
    }
    std::cout << "checking Identifiers..." << std::endl;
    if(!checkIds()){
        return false;
    }
    return true;
}