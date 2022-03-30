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
                writeLine("\n" + node->getFirstChild()->getName() + ":");
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
            {
                // restore onto stack
                // check it's children. (gauranteed 2 children)
                Registers source = node->getChildren()[1]->getReg();
                // Get a source register
                if(source == NONE){
                    // either a number or identifier
                    AST *temp = node->getChildren()[1];
                    if(temp->theExprType == identifier){
                        // do something else
                        SymEntry *tempEntry = temp->getTableEntry();
                        int offset = tempEntry->offset;
                        source = getNextReg();
                        if(offset == -1){
                            // global variable
                            writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(temp->theExprType == number){
                        source = getNextReg();
                        writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
                    }else{
                        std::cerr << "ERROR - an expression doesn't have a reg set up." << std::endl;
                        return false;
                    }
                }

                

                break;
            }
            default:
                ;
        }
    }else{
        switch(node->theExprType){
            case unary:
                break;
            case arithmetic:
            {
                // check it's children. (gauranteed 2 children)
                Registers childOne = node->getChildren()[0]->getReg();
                Registers childTwo = node->getChildren()[1]->getReg();
                
                if(childOne == NONE){
                    AST *temp = node->getFirstChild();
                    if(temp->theExprType == identifier){
                        // do something else
                        SymEntry *tempEntry = temp->getTableEntry();
                        int offset = tempEntry->offset;
                        childOne = getNextReg();
                        if(offset == -1){
                            // global variable
                            writeTabbedLine("lw " + regToStr(childOne) + ", _" + temp->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(childOne) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(temp->theExprType == number){
                        // do another separate thing.
                        childOne = getNextReg();
                        writeTabbedLine("li " + regToStr(childOne) + ", " + std::to_string(temp->getNum()));
                    }else{
                        std::cerr << "ERROR - an expression doesn't have a reg set up." << std::endl;
                        return false;
                    }
                }

                if(childTwo == NONE){
                    AST *temp = node->getChildren()[1];
                    if(temp->theExprType == identifier){
                        // do something else
                        SymEntry *tempEntry = temp->getTableEntry();
                        int offset = tempEntry->offset;
                        childTwo = getNextReg();
                        if(offset == -1){
                            // global variable
                            writeTabbedLine("lw " + regToStr(childTwo) + ", _" + temp->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(childTwo) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(temp->theExprType == number){
                        // do another separate thing.
                        childTwo = getNextReg();
                        writeTabbedLine("li " + regToStr(childTwo) + ", " + std::to_string(temp->getNum()));
                    }else{
                        std::cerr << "ERROR - an expression doesn't have a reg set up." << std::endl;
                        return false;
                    }
                    
                }
                
                // free reg from children. 
                freeReg(childOne);
                freeReg(childTwo);
                node->getChildren()[0]->setReg(NONE);
                node->getChildren()[1]->setReg(NONE);

                // grab a new reg
                Registers dest = getNextReg();
                if(dest == NONE){
                    std::cerr << "ERROR: No registers remaining." << std::endl;
                    return false;
                }
                node->setReg(dest);

                // store reg in the node, and exec instruction
                std::string res = opToInstr(node->getTheOp()) + " " + regToStr(dest) + ", ";
                res += regToStr(childOne) + ", " + regToStr(childTwo);
                writeTabbedLine(res);
                break;
            }
            case identifier:
            {
                // check if its a decl or not...
                // SymEntry *entry = node->getTableEntry();
                // if(entry->isFunc || entry->offset == -1){
                    
                // }
                // if not, put it in a reg.
                // grab reg, store in node.
                // lw 
                break;
            }
            case number:
            {
                // Registers dest = getNextReg();
                // if(dest == NONE){
                //     std::cerr << "here";
                //     std::cerr << "ERROR: No registers remaining." << std::endl;
                //     return false;
                // }
                // node->setReg(dest);
                // // put it in a reg.
                // writeTabbedLine("li " + regToStr(dest) + ", " + std::to_string(node->getNum()));
                // store in node.
                break;
            }
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

void CodeGen::initRegList(){
    for(int i = NONE; i != s_seven; i++){
        Registers temp = static_cast<Registers>(i);
        regList.push_back({temp, true});
    }
    regList.push_back({s_seven, true});
}
