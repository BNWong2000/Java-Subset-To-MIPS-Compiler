#include "semantic.hpp"



bool Semantic::globalCheck_callback(AST *node){
    if(node->theNode == declaration){
        
        switch(node->theDeclType){
            case mainFunction: {

                // Check if the main function has previously been declared. 
                std::string name = node->getChildren()[0]->getChildren()[0]->getName();
                if(tables[0].find(name) != tables[0].end()){
                    std::cerr << "main function already exists!" << std::endl;
                    return false;
                }
                symEntry *temp = new symEntry();
                temp->isFunc = true;
                tables[0].insert({name, temp});
                break;
            }
            case function: {
                AST *funcDecl = node->getChildren()[0]->getChildren()[0];
                std::string name = funcDecl->getChildren()[0]->getName();
                if(tables[0].find(name) != tables[0].end()){
                    std::cerr << "Duplicate function of name \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                
                symEntry *entry = new symEntry( node->getChildren()[0]->getTheVar());
                entry->isFunc = true;
                for(int i = 1; i < funcDecl->getChildren().size(); i++){
                    entry->addParam(funcDecl->getChildren()[i]->getTheVar());
                }
                tables[0].insert({name, entry});
                break;
            }
            case globalVariable: {
                std::string name = node->getChildren()[0]->getName();
                if(tables[0].find(name) != tables[0].end()){
                    std::cerr << "Duplicate global variable \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                symEntry *entry = new symEntry(node->getTheVar());
                entry->isFunc = false;
                
                tables[0].insert({name, entry});
                break;
            }
            default:
                ;
        }
    }
    return true;
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
    if(node->theNode == statement && node->theStmtType == blockStmt){
        depth++;
    }
    if(node->theNode == declaration && node->theDeclType == function){
        // function or main declaration (both have declarator children)
        std::unordered_map<std::string, symEntry *> currScope;
        scopeStack.push_back(tables.size());
        tables.push_back(currScope); 
    }else if(node->theNode == declaration){
        if(node->theDeclType == variable || node->theDeclType == parameter){
            std::string name = node->getFirstChild()->getName();
            if(depth >= 3){
                // This indicates a nested block within a function
                std::cerr << "ERROR: local declaration of \"" << name << "\" is not in outermost block at line " << node->getLine() << std::endl;  
            }
            // variable
            std::unordered_map<std::string, symEntry *> &top = tables[scopeStack.back()];
            if(top.find(name) == top.end()){ 
                // not inside of the top scope
                symEntry *entry = new symEntry(node->getTheVar());
                entry->isFunc = false;
                top.insert({name, entry});
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
                node->setTableEntry(currInd);
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

    if(node->theNode == statement && node->theStmtType == blockStmt){
        depth--;
    }
    return true;
}

bool Semantic::typeCheck(AST *node){
    if(node->theNode == expression){
        switch (node->theExprType){
            case identifier:
                if(!tables[node->getTableEntry()][node->getName()]->isFunc)
                    node->setTheVar(tables[node->getTableEntry()][node->getName()]->type);
                else
                    node->setTheVar(not_var); // assign it to this for functions
                    // so that a function name can't be used as an identifier.
                break;
            case functionCall: {
                symEntry *lookup = tables[0][node->getFirstChild()->getName()];
                node->setTheVar(lookup->type);
                if((node->getChildren().size()-1) != lookup->params.size()){
                    std::cerr << "Function call on line " << node->getLine() << " has a different number of parameters than the function requires." << std::endl;
                    return false;
                }
                for(int i = 1; i < node->getChildren().size(); i++){
                    if(node->getChildren()[i]->getTheVar() != lookup->params[i-1]){
                        std::cerr << "Function call on line " << node->getLine() 
                        << " has one or more parameter type mismatches." << std::endl;
                        return false;
                    }
                }
                break;
            }
            case unary:
                if(node->getTheOp() == op_SUB){
                    node->setTheVar(var_INT);
                }else{
                    node->setTheVar(var_BOOL);
                }
                if(node->getFirstChild()->getTheVar() != node->getTheVar()){
                    std::cerr << "Error on line " << node->getLine() << ": unary operator type mismatch." << std::endl;
                    return false;
                }
                break;
            case relational:
                if(node->getFirstChild()->getTheVar() != var_INT || node->getChildren()[1]->getTheVar() != var_INT){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for relational expression." << std::endl;
                    return false;
                }
                break;
            case equality: {
                Variables type = node->getFirstChild()->getTheVar();
                if(type != var_BOOL && type != var_INT){
                    std::cerr << "Error on line " << node->getLine() << ": invalid type used in equality expression." << std::endl;
                    return false;
                }
                if(type != node->getChildren()[1]->getTheVar()){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for equality expression." << std::endl;
                    return false;
                }
                break;
            }
            case conditional:
                if(node->getFirstChild()->getTheVar() != var_BOOL || node->getChildren()[1]->getTheVar() != var_BOOL){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for conditional expression." << std::endl;
                    return false;
                }
                break;
            case arithmetic:
                if(node->getFirstChild()->getTheVar() != var_INT || node->getChildren()[1]->getTheVar() != var_INT){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for arithmetic expression." << std::endl;
                    return false;
                }
                break;
            default:
                ;
        }
    }else if(node->theNode == statement){
        switch (node->theStmtType){
        case ifStmt: // if, ifelse, and while should check for the same things. 
        case ifElseStmt: // hence the lack of break.
        case whileStmt:
            // look at it's conditional expression for bool type. 
            if(node->getFirstChild()->getTheVar() != var_BOOL){
                std::cerr << "Error on line " << node->getLine() << ": expected a boolean expression." << std::endl;
                return false;
            }
            break;
        case assignment: {
            // compare its children's types
            Variables type = node->getFirstChild()->getTheVar();
            if(type != node->getChildren()[1]->getTheVar() || type == not_var){
                std::cerr << "Error on line " << node->getLine() << ": assignment type mismatch." << std::endl;
                return false;
            }
            node->setTheVar(type);
            break;
        }
        default:
            break;
        }
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

bool Semantic::checkTypes(){
    if(!postOrder(root, &Semantic::typeCheck, this)){
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
    std::cout << "checking types..." << std::endl;
    if(!checkTypes()){
        return false;
    }

    return true;
}