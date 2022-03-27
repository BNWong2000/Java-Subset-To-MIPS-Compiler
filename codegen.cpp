#include "codegen.hpp"
#include "ast.hpp"
#include "symbolTable.hpp"

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
            writeTabbedLine(".align 2");
        }
    }
    return true;
}

bool CodeGen::prePass(AST *node){
    if(node->theNode == declaration){
        switch (node->theDeclType){
            case mainFunction:
                break;
            case function:
                initFuncStack = stackLevel;
                break;
            case declarator:
                // Label
                writeLine(node->getFirstChild()->getName() + ":");
                writeTabbedLine("subu $sp, $sp, 4");
                storeOnStack();
                writeTabbedLine("sw $ra, 0($sp)");
                currParamCount = 0;
                break;
            case parameter:
                
                break;
            default:
                ;
        }
    }else if(node->theNode == expression){
        switch (node->theExprType){
            case identifier:
            {
                SymEntry *entry = node->getTableEntry();
                if(entry->isFunc){
                    break;
                }
                // check if global or not
                if(entry->isGlobal){
                    //
                }else{
                    // check if stored on stack yet or not. 
                    if(entry->offset == -1){
                        // store on stack and record...
                        writeTabbedLine("subu $sp, $sp, 4");
                        entry->offset = storeOnStack();
                    }
                }
                break;
            }
            default:
                ;
        }
    }
    return true;
}

bool CodeGen::postPass(AST *node){
    if(node->theNode == declaration){
        switch (node->theDeclType){
            case mainFunction:
                writeTabbedLine("li $v0, 10");
                writeTabbedLine("syscall");
                break;
            case function:
            {
                int temp = stackLevel - initFuncStack;
                writeTabbedLine("");
                if(temp > 0){
                    writeTabbedLine("addu $sp, $sp, " + std::to_string(temp));
                }
                writeTabbedLine("lw $ra," + std::to_string(temp-4) + "($sp)");
                writeTabbedLine("jr $ra");
                break;
            }
            case declarator:
                currParamCount = 0;
                break;
            case parameter:
                writeTabbedLine("sw $a" + std::to_string(currParamCount) + ", 0($sp)");
                currParamCount++;
                break;
            default:
                ;
        }
    }else if(node->theNode == statement){
        switch(node->theStmtType){
            case assignment:
                // restore onto stack
                break;
            default:
                ;
        }
    }else{
        switch(node->theExprType){
            case unary:
                break;
            case arithmetic:
                // check it's children. 
                // free reg from children. 
                // grab a new reg
                // store reg in the node, and exec instruction
                break;
            case identifier:
                // check if its a decl or not...
                // if not, put it in a reg.
                // grab reg, store in node.
                // lw 
                break;
            case number:
                // put it in a reg.
                // store in node.
                break;
            default:
                ;
        }
    }
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
