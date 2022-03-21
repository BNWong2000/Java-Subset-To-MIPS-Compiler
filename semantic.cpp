#include "semantic.hpp"


bool Semantic::globalCheck_callback(AST *node){
    if(node->theNode == declaration){
        
        switch(node->theDeclType){
            case mainFunction: {
                // Check if the main function has previously been declared. 
                if(mainFunctionName.size() > 0){
                    std::cerr << "Error on line " << node->getLine() <<": main function already exists" << std::endl;
                    return false;
                }
                std::string name = node->getChildren()[0]->getChildren()[0]->getName();
                // if(name.compare("main") != 0){
                //     std::cerr << "Error on line " << node->getLine() << ": improper declaration of function \"" << name << "\". missing return value." << std::endl;
                //     return false;
                // }
                // if(tables[1].find(name) != tables[1].end()){
                //     std::cerr << "Error on line " << node->getLine() <<": main function already exists" << std::endl;
                //     return false;
                // }
                mainFunctionName = name;
                SymEntry *temp = new SymEntry();
                temp->isFunc = true;
                tables[1].insert({name, temp});
                break;
            }
            case function: {
                AST *funcDecl = node->getChildren()[0]; // ->getChildren()[0]
                std::string name = funcDecl->getChildren()[0]->getName();
                if(tables[1].find(name) != tables[1].end()){
                    std::cerr << "Error on line " << node->getLine() << ": duplicate function of name \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                
                SymEntry *entry = new SymEntry(node->getTheVar());
                entry->isFunc = true;
                for(int i = 1; i < funcDecl->getChildren().size(); i++){
                    entry->addParam(funcDecl->getChildren()[i]->getTheVar());
                }
                tables[1].insert({name, entry});
                break;
            }
            case globalVariable: {
                std::string name = node->getChildren()[0]->getName();
                if(tables[1].find(name) != tables[1].end()){
                    std::cerr << "Error on line " << node->getLine() << ": duplicate global variable \"" << name << "\" being declared." << std::endl;
                    return false;
                }
                SymEntry *entry = new SymEntry(node->getTheVar());
                entry->isFunc = false;
                
                tables[1].insert({name, entry});
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
        std::unordered_map<std::string, SymEntry *> currScope;
        scopeStack.push_back(tables.size());
        tables.push_back(currScope); 
    }else if(node->theNode == declaration){
        if(node->theDeclType == variable || node->theDeclType == parameter){
            std::string name = node->getFirstChild()->getName();
            if(depth >= 4){
                // This indicates a nested block.
                std::cerr << "Error on line " << node->getLine() << ": local declaration of \"" << name << "\" is not in outermost block at line " << node->getLine() << std::endl;  
                return false;
            }
            // variable
            std::unordered_map<std::string, SymEntry *> &top = tables[scopeStack.back()];
            if(top.find(name) == top.end()){ 
                // not inside of the top scope
                SymEntry *entry = new SymEntry(node->getTheVar());
                entry->isFunc = false;
                top.insert({name, entry});
            }else{
                // error
                std::cerr << "Error on line " << node->getLine() << ": identifier \"" << name << "\" already exists in this scope. " << std::endl;
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
                node->setTableEntry(tables[currInd][name]);
                break;
            }
        }

        if(!found){
            std::cerr << "Error on line " << node->getLine() << ": identifier \"" << name << "\" has not yet been declared. " << std::endl;
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
                if(!node->getTableEntry()->isFunc)
                    node->setTheVar(node->getTableEntry()->type);
                else
                    node->setTheVar(not_var); // assign it to this for functions
                    // so that a function name can't be used as an identifier.
                break;
            case functionCall: {
                std::string name = node->getFirstChild()->getName();
                if(name.compare(mainFunctionName) == 0){
                    std::cerr << "Error on line " << node->getLine() << ": cannot call main function" << std::endl;
                    return false;
                }
                SymEntry *lookup;
                if(tables[1].find(name) != tables[1].end()){
                    lookup = tables[1][name];
                }else{
                    lookup = tables[0][name];
                }
                
                node->setTableEntry(lookup);
                node->setTheVar(lookup->type);
                if((node->getChildren().size()-1) != lookup->params.size()){
                    std::cerr << "Error on line " << node->getLine() << ": function call \"" << name << "\" has a different number of parameters than the function requires." << std::endl;
                    return false;
                }
                for(int i = 1; i < node->getChildren().size(); i++){
                    if(node->getChildren()[i]->getTheVar() != lookup->params[i-1]){
                        std::cerr << "Error on line " << node->getLine() << ": function call \"" << name 
                        << "\" has one or more parameter type mismatches." << std::endl;
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
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for \"" << opToString(node->getTheOp()) << "\" expression." << std::endl;
                    return false;
                }
                break;
            case equality: {
                Variables type = node->getFirstChild()->getTheVar();
                if(type != var_BOOL && type != var_INT){
                    std::cerr << "Error on line " << node->getLine() << ": invalid type used in \"" << opToString(node->getTheOp()) << "\" expression." << std::endl;
                    return false;
                }
                if(type != node->getChildren()[1]->getTheVar()){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for \"" << opToString(node->getTheOp()) << "\" expression. " << std::endl;
                    return false;
                }
                break;
            }
            case conditional:
                if(node->getFirstChild()->getTheVar() != var_BOOL || node->getChildren()[1]->getTheVar() != var_BOOL){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for \"" << opToString(node->getTheOp()) << "\" expression." << std::endl;
                    return false;
                }
                break;
            case arithmetic:
                if(node->getFirstChild()->getTheVar() != var_INT || node->getChildren()[1]->getTheVar() != var_INT){
                    std::cerr << "Error on line " << node->getLine() << ": type mismatch for \"" << opToString(node->getTheOp()) << "\" arithmetic expression." << std::endl;
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
                std::cerr << "Error on line " << node->getLine() << ": type mismatch for \"=\"." << std::endl;
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

bool Semantic::miscCheckPre(AST* node){
    if(node->theNode == statement){
        switch (node->theStmtType){
        case whileStmt:
            currLoopCount++;
            break;
        case breakStmt:
            if(currLoopCount == 0){
                std::cerr << "Error on line " << node->getLine() << ": break statement not in while loop. " << std::endl;
                return false;
            }
            break;
        case returnStmt:
            break;
        default:
            ;
        }
    }else if(node->theNode == declaration){
        if(node->theDeclType == function ){
            // Note that main() doesn't have a header, but other functions do. 
            funcRetType = node->getTheVar();
            
            if(funcRetType == var_VOID){
                returnSatisfied = true;
            }else{
                returnSatisfied = false;
            }
        }else if(node->theDeclType == mainFunction){
            funcRetType = var_VOID;
            returnSatisfied = true;
        }
    }
    return true;
}

bool Semantic::miscCheckPost(AST* node){
    if(node->theNode == statement){
        switch (node->theStmtType){
        case whileStmt:
            currLoopCount--;
            break;
        case returnStmt:
            returnSatisfied = true;
            if(node->getChildren().size() > 0){
                // There is something being returned.
                if(node->getFirstChild()->getTheVar() != funcRetType){
                    std::cerr << "Error on line " << node->getLine() << ": Improper return type." << std::endl;
                    return false;
                }
            }else{
                // There is no return value
                if(funcRetType != var_VOID){
                    std::cerr << "Error on line " << node->getLine() << ": No return value specified." <<std::endl;
                    return false;
                }
            }
            // check if it's appropriate. if it is, reset retType to not_var.
            break;
        default:
            ;
        }
    }else if(node->theNode == declaration){
        if(node->theDeclType == function){
            if(!returnSatisfied){
                std::cerr << "Error on line " << node->getLine() << ": No return statement on non-void function." << std::endl;
                return false;
            }
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
    // if(tables[1].find("main") == tables[1].end()){
    //     std::cerr << "Error: no main function found" << std::endl;
    //     return false;
    // }
    if(mainFunctionName.size() == 0){
        std::cerr << "Error: no main function found" << std::endl;
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

bool Semantic::checkMisc(){
    if(!prePostOrder(root, &Semantic::miscCheckPre, &Semantic::miscCheckPost, this)){
        return false;
    }
    return true;
}

bool Semantic::checkTree(){
    // std::cout << "checking globals..." << std::endl;
    if(!checkGlobals()){
        return false;
    }
    // std::cout << "checking Identifiers..." << std::endl;
    if(!checkIds()){
        return false;
    }
    // std::cout << "checking types..." << std::endl;
    if(!checkTypes()){
        return false;
    }
    // std::cout << "Checking the rest..." << std::endl;
    if(!checkMisc()){
        return false;
    }
    // std::cout << "Semantically correct." << std::endl;
    return true;
}

void Semantic::createPreDef(){
    std::unordered_map<std::string, SymEntry *> preDefTable;

    // getchar int getchar()
    SymEntry *getcharEntry = new SymEntry(var_INT);
    getcharEntry->isFunc = true;
    preDefTable.insert({"getchar", getcharEntry});

    // halt	void halt()
    SymEntry *haltEntry = new SymEntry(var_VOID);
    haltEntry->isFunc = true;
    preDefTable.insert({"halt", haltEntry});

    // printb void printb(boolean b)
    SymEntry *printbEntry = new SymEntry(var_VOID);
    printbEntry->isFunc = true;
    printbEntry->addParam(var_BOOL);
    preDefTable.insert({"printb", printbEntry});
    

    // printc void printc(int c)
    SymEntry *printcEntry = new SymEntry(var_VOID);
    printcEntry->isFunc = true;
    printcEntry->addParam(var_INT);
    preDefTable.insert({"printc", printcEntry});

    // printi void printi(int i)
    SymEntry *printiEntry = new SymEntry(var_VOID);
    printiEntry->isFunc = true;
    printiEntry->addParam(var_INT);
    preDefTable.insert({"printi", printiEntry});

    // prints void prints(string s)
    SymEntry *printsEntry = new SymEntry(var_VOID);
    printsEntry->isFunc = true;
    printsEntry->addParam(var_STRING);
    preDefTable.insert({"prints", printsEntry});

    // stick it onto the table and scope stack. 
    tables.push_back(preDefTable);
    scopeStack.push_back(0);
}
