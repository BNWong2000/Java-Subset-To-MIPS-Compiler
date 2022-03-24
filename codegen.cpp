#include "codegen.hpp"
#include "ast.hpp"

bool prePostOrder(AST *curr, bool (CodeGen::*preCall)(AST *), bool (CodeGen::*postCall)(AST *), CodeGen *cGen){
    if(!(cGen->*preCall)(curr)){
        return false;
    }
    for(int i = 0; i < curr->getChildren().size(); i++){
        if(!prePostOrder(curr->getChildren()[i], preCall, postCall, cGen)){
            return false;
        }
    }
    if(!(cGen->*postCall)(curr)){
        return false;
    }
    return true;
}

bool postOrder(AST *curr, bool (CodeGen::*callback)(AST *), CodeGen *cGen){
    for(int i = 0; i < curr->getChildren().size(); i++){
        if(!postOrder(curr->getChildren()[i], callback, cGen)){
            return false;
        }
    }
    if(!(cGen->*callback)(curr)){
        return false;
    }
    return true;
}


// Deals with global variables and string literals.
bool CodeGen::globalsPass(AST *node){
    if(node->theNode == declaration){
        // GLobal Variable
        if(node->theDeclType == globalVariable){
            std::string result = "_" + node->getFirstChild()->getName() + ":\t"; 
            // all globals will have an extra _ in front of their name.
            // This prevents someone from accidentally naming it after what I called
            // my strings. (i.e., str1)
            result += ".word 0";
            writeLine(result);
        }
    }else if(node->theNode == expression){
        // check for string lit
        if(node->theExprType == stringLit){
            // do stuff here....
            std::string stringLit = node->getName();
            std::string result = "str" + std::to_string(node->getNum()) + ":\t.byte ";  
            for(int i = 0; i < stringLit.size(); i++){
                result += std::to_string(int(stringLit[i]));
                result += ", ";
            }
            result += "0";
            writeLine(result);
        }
    }
    return true;
}

bool CodeGen::prePass(AST *node){
    if(node->theNode == declaration){
        //
    }
    return true;
}

bool CodeGen::postPass(AST *node){
    return true;
}

bool CodeGen::generate(){
    writeLine("\t.data");
    if(!postOrder(tree, &CodeGen::globalsPass, this)){
        return false;
    }
    writeLine("\n\t.text");
    writeLine("\t.globl " + tree->getMainFunction());
    return prePostOrder(tree, &CodeGen::prePass, &CodeGen::postPass, this);
}
