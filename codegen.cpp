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
            std::string stringLit = node->getName();
            std::string result = "str" + std::to_string(node->getNum()) + ":\t.byte ";  
            int strLen = 0;
            for(int i = 1; i < stringLit.size()-1; i++){
                // bounds are from 1 to size()-2, to ignore the quotes at the start/finish
                strLen++;
                if(stringLit[i] == '\\' && i+1 < stringLit.size()-1){
                    switch (stringLit[i+1]){
                        case 'n':
                            result += std::to_string(int('\n'));
                            i++;
                            break;
                        case 'b':
                            result += std::to_string(int('\b'));
                            i++;
                            break;
                        case 'f':
                            result += std::to_string(int('\f'));
                            i++;
                            break;
                        case 't':
                            result += std::to_string(int('\t'));
                            i++;
                            break;
                        case 'r':
                            result += std::to_string(int('\r'));
                            i++;
                            break;
                        case '\'':
                            result += std::to_string(int('\''));
                            i++;
                            break;
                        case '\"':
                            result += std::to_string(int('\"'));
                            i++;
                            break;
                        default:
                            ;
                    }
                }else{
                    result += std::to_string(int(stringLit[i]));
                }
                result += ", ";
            }
            result += "0";
            writeLine(result);
            writeTabbedLine(".align 2");
            // store the length of the string.
            writeLine("str" + std::to_string(node->getNum()) + "Len:\t.word " + std::to_string(strLen + 1));
        }
    }
    return true;
}

bool CodeGen::prePass(AST *node){
    if(node->theNode == declaration){
        switch (node->theDeclType){
            case mainFunction:
                initFuncStack = stackLevel;
                writeLine("main:");
                writeTabbedLine("jal _" + node->getFirstChild()->getFirstChild()->getName());
                writeLine("\n_" + node->getFirstChild()->getFirstChild()->getName() + ":");
                break;
            case function:
                initFuncStack = stackLevel;
                writeLine("\n_" + node->getFirstChild()->getFirstChild()->getName() + ":");
                writeTabbedLine("subu $sp, $sp, 4");
                storeOnStack();
                writeTabbedLine("sw $ra, 0($sp)");
                currParamCount = 0;
                break;
            case declarator:
                // Label
                
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
                if(!entry->isGlobal){
                    // check if stored on stack yet or not. 
                    if(entry->offset == -1){
                        // store on stack and record...
                        writeTabbedLine("subu $sp, $sp, 4    # " + node->getName() );
                        
                        entry->offset = storeOnStack();
                    }
                }
                break;
            }
            case conditional:
            {
                shortCircuitCount++;
                auto childOne = node->getFirstChild();
                node->setSC(shortCircuitCount);
                childOne->setBlockID(shortCircuitCount);
                if(node->getTheOp() == op_AND){
                    childOne->setConditionChild(1);
                }else if(node->getTheOp() == op_OR){
                    childOne->setConditionChild(2);
                }
                // node->setReg(getNextReg());
                break;
            }
            default:
                ;
        }
    }else if(node->theNode == statement){
        switch(node->theStmtType){
            case ifStmt: // if always has 2 children
            {
                currIfCount++;
                auto children = node->getChildren();
                children[0]->setIsIfOrLoop(ifConditional); // conditional for if
                children[0]->setBlockID(currIfCount); 
                children[1]->setIsIfOrLoop(ifBlock); // block/body
                children[1]->setBlockID(currIfCount); 
                // writeLine("ifStart" + std::to_string(currIfCount) + ":"); // print label
                // node->setNum(currIfCount); // store it in the node.
                break;
            }
            case ifElseStmt: // ifelse always has 3 children
            {
                currIfCount++;
                auto children = node->getChildren();
                children[0]->setIsIfOrLoop(elseConditional); // conditional for if/else
                children[0]->setBlockID(currIfCount);
                children[1]->setIsIfOrLoop(ifBlock); // if block/body
                children[1]->setBlockID(currIfCount);
                children[2]->setIsIfOrLoop(elseBlock); // else block/body
                children[2]->setBlockID(currIfCount);
                // writeLine("ifStart" + std::to_string(currIfCount) + ":"); // print label
                // node->setNum(currIfCount); // store it in the node.
                break;
            }
            case whileStmt: // while always has 2 children
            {
                currWhileCount++;
                whileStack.push(currWhileCount);
                auto children = node->getChildren();
                // node->setNum(currWhileCount);
                children[0]->setIsIfOrLoop(whileConditional); // conditional
                children[0]->setBlockID(currWhileCount); 
                children[1]->setIsIfOrLoop(whileBlock); // block/body
                children[1]->setBlockID(currWhileCount); 
                writeLine("whileStart" + std::to_string(currWhileCount) + ":"); // print label
                break;
            }
            case blockStmt:
                break;
            
            default:
                ;
        }
    }
    switch(node->getIsIfOrLoop()){
        case ifBlock: // if statement conditional
            break;
        case elseBlock: // else statement conditional
            writeLine("elseStart" + std::to_string(node->getBlockID()) + ":");
            break;
        case whileBlock: // while statement conditional
            break;
        default:
            ;
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
                if(node->getTheVar() != var_VOID){
                    writeTabbedLine(".data");
                    writeLine("noRetErr" + std::to_string(++noRetCount) + ":\t.asciiz \"Runtime Error: No return from function\n\"");
                    writeTabbedLine(".text");
                    writeTabbedLine("la $a0, noRetErr"+ std::to_string(noRetCount));
                    writeTabbedLine("jal ERROR");
                }else{
                    int temp = stackLevel - initFuncStack;
                    writeTabbedLine("");
                    writeTabbedLine("lw $ra, " + std::to_string(temp-4) + "($sp)");
                    if(temp > 0){
                        writeTabbedLine("addu $sp, $sp, " + std::to_string(temp));
                    }
                    writeTabbedLine("jr $ra");
                }
                freeAllReg();
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
                // check it's children. (gauranteed 2 children)
                Registers source = node->getChildren()[1]->getReg();
                // Get a source register
                if(source == NONE){
                    // either a number or identifier
                    AST *temp = node->getChildren()[1];
                    source = getNextReg();
                    // std::cout << "here" << std::endl;
                    if(temp->theNode == statement){
                        // this means our dest is another assignment (i.e., i = j = k;)
                        auto sourceEntry = temp->getFirstChild()->getTableEntry();
                        
                        if(sourceEntry->isGlobal){
                            writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getFirstChild()->getName());
                        }else{
                            int offset = sourceEntry->offset;
                            writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                        
                    }else if(temp->theExprType == identifier){
                        // do something else
                        SymEntry *tempEntry = temp->getTableEntry();
                        int offset = tempEntry->offset;
                        if(offset == -1){
                            // global variable
                            writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(temp->theExprType == number || temp->theExprType == boolLit){
                        writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
                    }else{
                        std::cerr << "ERROR - an expression doesn't have a reg set up." << std::endl;
                        return false;
                    }
                }
                
                SymEntry *destEntry = node->getFirstChild()->getTableEntry();
                if(destEntry->isGlobal){
                    writeTabbedLine("sw " + regToStr(source) + ", _" + node->getFirstChild()->getName());
                }else{
                    writeTabbedLine("sw " + regToStr(source) + ", " + std::to_string(stackLevel - destEntry->offset) + "($sp)");
                }
                freeReg(source);
                
                break;
            }
            case returnStmt:
            {
                int temp = stackLevel - initFuncStack;
                writeTabbedLine("");
                writeTabbedLine("lw $ra, " + std::to_string(temp-4) + "($sp)");
                
                if(node->getChildren().size() == 1){
                    
                    // node is returning something...
                    auto child = node->getFirstChild();
                    if(child->theNode == statement){
                        // Assignment (edge case);
                        child = child->getFirstChild();
                    }
                    if(child->theExprType == number){
                        writeTabbedLine("li $v0, " + std::to_string(child->getNum()));
                    }else if(child->theExprType == identifier){
                        auto entry = child->getTableEntry();
                        if(entry->isGlobal){
                            writeTabbedLine("lw $v0, _" + child->getName());
                        }else{
                            writeTabbedLine("lw $v0, " + std::to_string(stackLevel - entry->offset) + "($sp)");
                        }
                    }else if(child->theExprType == boolLit){
                        writeTabbedLine("li $v0, " + std::to_string(child->getNum()));
                    }else{
                        writeTabbedLine("move $v0, " + regToStr(child->getReg()));
                    }
                }
                if(temp > 0){
                    writeTabbedLine("addu $sp, $sp, " + std::to_string(temp));
                }
                writeTabbedLine("jr $ra");
                break;
            }
            case ifStmt:
                writeLine("ifEnd" + std::to_string(node->getFirstChild()->getBlockID()) + ":"); // print label
                break;
            case ifElseStmt:
                writeLine("ifEnd" + std::to_string(node->getFirstChild()->getBlockID()) + ":"); // print label
                break;
            case blockStmt:
                break;
            case whileStmt:
                whileStack.pop();
                writeLine("whileEnd" + std::to_string(node->getFirstChild()->getBlockID()) + ":"); // print label
                break;
            case breakStmt:
                writeTabbedLine("j whileEnd" + std::to_string(whileStack.top()));
                break;
            default:
                ;
        }
    }else if(node->theNode == expression){
        switch(node->theExprType){
            case unary:
            {
                auto child = node->getFirstChild();
                Registers source = child->getReg();
                if(source == NONE){
                    if(child->theExprType == identifier){
                        SymEntry *tempEntry = child->getTableEntry();
                        int offset = tempEntry->offset;
                        source = getNextReg();
                        if(tempEntry->isGlobal){
                            // global variable
                            writeTabbedLine("lw " + regToStr(source) + ", _" + child->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(child->theExprType == number || child->theExprType == boolLit){
                        // do another separate thing.
                        source = getNextReg();
                        writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(child->getNum()));
                    }else{
                        std::cerr << "ERROR - an expression doesn't have a reg set up." << std::endl;
                        return false;
                    }
                }
                freeReg(source);
                Registers dest = getNextReg();
                if(node->getTheOp() == op_SUB){
                    writeTabbedLine("negu " + regToStr(dest) + ", " + regToStr(source));
                }else if(node->getTheOp() == op_NOT){
                    writeTabbedLine("xori " + regToStr(dest) + ", " + regToStr(source) + ", 1");
                }
                node->setReg(dest);
                break;
            }
            // all binary ops have the same tree structure.
            // and at this point, we know our semantics are good. 
            case arithmetic:
            case equality:
            case conditional:
            case relational:
            {
                // check it's children. (gauranteed 2 children)
                Registers childOne = node->getChildren()[0]->getReg();
                Registers childTwo = node->getChildren()[1]->getReg();
                auto childNodeOne = node->getFirstChild();
                if(childNodeOne->theNode == statement){
                    childNodeOne = childNodeOne->getFirstChild();
                }
                childOne = childNodeOne->getReg();
                if(childOne == NONE){
                    AST *temp = childNodeOne;
                    if(temp->theExprType == identifier){
                        // do something else
                        SymEntry *tempEntry = temp->getTableEntry();
                        int offset = tempEntry->offset;
                        childOne = getNextReg();
                        if(tempEntry->isGlobal){
                            // global variable
                            writeTabbedLine("lw " + regToStr(childOne) + ", _" + temp->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(childOne) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(temp->theExprType == number || temp->theExprType == boolLit){
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
                    if(temp->theNode == statement){
                        temp = temp->getFirstChild();
                    }
                    if(temp->theExprType == identifier){
                        // do something else
                        SymEntry *tempEntry = temp->getTableEntry();
                        int offset = tempEntry->offset;
                        childTwo = getNextReg();
                        if(tempEntry->isGlobal){
                            // global variable
                            writeTabbedLine("lw " + regToStr(childTwo) + ", _" + temp->getName());
                        }else{
                            // local variable. find stack offset.
                            writeTabbedLine("lw " + regToStr(childTwo) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                        }
                    }else if(temp->theExprType == number || temp->theExprType == boolLit){
                        // do another separate thing.
                        childTwo = getNextReg();
                        writeTabbedLine("li " + regToStr(childTwo) + ", " + std::to_string(temp->getNum()));
                    }else{
                        std::cerr << "ERROR - an expression doesn't have a reg set up." << std::endl;
                        return false;
                    }
                }

                if(node->getTheOp() == op_DIV || node->getTheOp() == op_MOD){
                    // div by zero error
                    writeTabbedLine("bnez " + regToStr(childTwo) + ", goodDiv"+ std::to_string(++divZeroCount));
                    writeTabbedLine(".data");
                    writeLine("divZeroErr" + std::to_string(divZeroCount) + ":\t.asciiz \"Runtime Error: divide by zero\n\"");
                    writeTabbedLine(".text");
                    writeLine("divCheck" + std::to_string(divZeroCount) + ":");
                    writeTabbedLine("la $a0, divZeroErr"+ std::to_string(divZeroCount));
                    writeTabbedLine("jal ERROR");
                    writeLine("goodDiv" + std::to_string(divZeroCount) + ":");
                }
                
                // free reg from children. 
                // freeReg(childOne);
                freeReg(childTwo);

                // grab a new reg
                // Registers dest = getNextReg();
                Registers dest = node->getReg();
                if(dest == NONE){
                    dest = childOne;
                    // std::cerr << "hi 2212312341 op is" << opToString(node->getTheOp()) << std::endl;
                    // return false;
                }else{
                    // std::cerr << "hi 2 op is" << opToString(node->getTheOp()) << std::endl;
                }
                node->setReg(dest);

                // store reg in the node, and exec instruction
                std::string res = opToInstr(node->getTheOp()) + " " + regToStr(dest) + ", ";
                res += regToStr(childOne) + ", " + regToStr(childTwo);
                writeTabbedLine(res); 
                
                if(node->getTheOp() == op_AND || node->getTheOp() == op_OR){
                   
                    writeLine("cond" + std::to_string(node->getSC()) + ":");
                }
                node->getChildren()[0]->setReg(NONE);
                node->getChildren()[1]->setReg(NONE);
                break;
            }
            case functionCall:
            {
                auto registerList = storeCurrRegisters();
                auto childList = node->getChildren();
                if(childList.size() > 5){
                    std::cerr << "ERROR: More than 4 parameters for function " << node->getFirstChild()->getName() << std::endl;
                    return false;
                }
                for(int i = 1; i < childList.size(); i++){
                    auto child = childList[i];
                    if(child->theNode == statement){
                        // assignment (edge case)
                        child = child->getFirstChild();
                    }
                    if(child->theExprType == number || child->theExprType == boolLit){
                        writeTabbedLine("li $a" + std::to_string(i - 1) + ", " + std::to_string(child->getNum()));
                    }else if(child->theExprType == stringLit){
                        writeTabbedLine("la $a0, str" + std::to_string(child->getNum()));
                        writeTabbedLine("lw $a1, str" + std::to_string(child->getNum()) + "Len");
                    }else{
                        if(child->getReg() == NONE){
                            SymEntry *symEntry = child->getTableEntry();
                            if(symEntry->isGlobal){
                                writeTabbedLine("lw $a" + std::to_string(i - 1) + ", _" + child->getName());
                            }else{
                                writeTabbedLine("lw $a" + std::to_string(i - 1) + ", " + std::to_string(stackLevel - symEntry->offset) + "($sp)");
                            }
                            
                        }else{
                            // it's a function or expression
                            writeTabbedLine("move $a" + std::to_string(i - 1) + ", " + regToStr(child->getReg()));
                        }
                    }
                }
                writeTabbedLine("jal _" + node->getFirstChild()->getName());
                
                restoreRegisters(registerList);
                if(node->getTheVar() != var_VOID){
                    // return value
                    Registers newRetVal = getNextReg();
                    writeTabbedLine("move " + regToStr(newRetVal) + ", $v0");
                    node->setReg(newRetVal);
                }
                break;
            }
            default:
                ;
        }
    }
    switch (node->getIsIfOrLoop()){
        case ifConditional:
        {
            auto temp = node;
            if(temp->theNode == statement){
                temp = temp->getFirstChild();
            }
            Registers source = temp->getReg();
            if(source == NONE){
                auto entry = temp->getTableEntry();
                source = getNextReg();
                if(temp->theExprType == boolLit){
                    writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
                }else if(entry->isGlobal){
                    writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
                }else{
                    int offset = entry->offset;
                    writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                }
            }
            writeTabbedLine("beqz " + regToStr(source) + ", ifEnd" + std::to_string(temp->getBlockID()));
            freeReg(source);
            break;
        }
        case elseConditional:
        {
            auto temp = node;
            if(temp->theNode == statement){
                temp = temp->getFirstChild();
            }
            Registers source = temp->getReg();
            if(source == NONE){
                auto entry = temp->getTableEntry();
                source = getNextReg();
                if(temp->theExprType == boolLit){
                    writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
                }else if(entry->isGlobal){
                    writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
                }else{
                    int offset = entry->offset;
                    writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                }
            }
            writeTabbedLine("beqz " + regToStr(source) + ", elseStart" + std::to_string(node->getBlockID()));
            freeReg(source);
            break;
        }
        case whileConditional:
        {
            auto temp = node;
            if(temp->theNode == statement){
                temp = temp->getFirstChild();
            }
            Registers source = temp->getReg();
            if(source == NONE){
                auto entry = temp->getTableEntry();
                source = getNextReg();
                if(temp->theExprType == boolLit){
                    writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
                }else if(entry->isGlobal){
                    writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
                }else{
                    int offset = entry->offset;
                    writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
                }
            }
            writeTabbedLine("beqz " + regToStr(source) + ", whileEnd" + std::to_string(node->getBlockID()));
            freeReg(source);
            break;
        }
        case ifBlock:
            writeTabbedLine("j ifEnd" + std::to_string(node->getBlockID()));
            break;
        case elseBlock:
            break;
        case whileBlock: // while loop block
            writeTabbedLine("j whileStart" + std::to_string(node->getBlockID()));
            break;
        default:
            ;
    }
    if(node->getConditionChild() == 1){
        // AND
        auto temp = node; 
        if(node->theNode == statement){
            temp = node->getFirstChild();
        }
        Registers source = temp->getReg();
        if(temp->getReg() == NONE){
            source = getNextReg();
            temp->setReg(source);
            auto entry = temp->getTableEntry();
            if(temp->theExprType == boolLit || temp->theExprType == number){
                writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
            }else if(entry->isGlobal){
                writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
            }else{
                int offset = entry->offset;
                writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
            }
        }
        writeTabbedLine("beqz " + regToStr(source) + ", cond" + std::to_string(node->getBlockID()));
    }else if(node->getConditionChild() == 2){
        // OR
        auto temp = node; 
        if(node->theNode == statement){
            temp = node->getFirstChild();
        }
        Registers source = temp->getReg();
        if(temp->getReg() == NONE){
            source = getNextReg();
            temp->setReg(source);
            auto entry = temp->getTableEntry();
            if(temp->theExprType == boolLit || temp->theExprType == number){
                writeTabbedLine("li " + regToStr(source) + ", " + std::to_string(temp->getNum()));
            }else if(entry->isGlobal){
                writeTabbedLine("lw " + regToStr(source) + ", _" + temp->getName());
            }else{
                int offset = entry->offset;
                writeTabbedLine("lw " + regToStr(source) + ", " + std::to_string(stackLevel - offset) + "($sp)");
            }
        }
        writeTabbedLine("bnez " + regToStr(source) + ", cond" + std::to_string(node->getBlockID()));
    }
    return true;
}

bool CodeGen::generate(){
    writeLine("\t.data");
    if(!postOrder(tree, &CodeGen::globalsPass, this)){
        return false;
    }
    writeLine("\n\t.text");
    writeLine("\t.globl main");
    
    bool rV = prePostOrder(tree, &CodeGen::prePass, &CodeGen::postPass, this);
    generateHeaderFuncs();
    return rV;
}

void CodeGen::initRegList(){
    for(int i = NONE; i != s_seven; i++){
        Registers temp = static_cast<Registers>(i);
        regList.push_back({temp, true});
    }
    regList.push_back({s_seven, true});
}

std::vector<std::pair<Registers, int>> CodeGen::storeCurrRegisters(){
    writeLine("");
    // std::cout << "STACK FRAMEEEE" << std::endl;
    std::vector<std::pair<Registers, int>> result;
    for(int i = 0; i < regList.size(); i++){
        if(!regList[i].second && regList[i].first != NONE){
            result.push_back({regList[i].first, 0});
            freeReg(regList[i].first);
        }
    }

    int currLevel = stackLevel;
    if(result.size() > 0)
        writeTabbedLine("subu $sp, $sp, " + std::to_string(result.size()*4));
    for(int i = 0; i < result.size(); i++){
        result[i].second = currLevel;
        writeTabbedLine("sw " + regToStr(result[i].first) + ", " + std::to_string(stackLevel - currLevel) + "($sp)");
        stackLevel += 4;
    }
    return result;
}

void CodeGen::restoreRegisters(std::vector<std::pair<Registers, int>> regs){
    for(int i = regs.size()-1; i >= 0; i--){
        stackLevel -= 4;
        claimReg(regs[i].first);
        writeTabbedLine("lw " + regToStr(regs[i].first) + ", " + std::to_string(stackLevel - regs[i].second) + "($sp)");
    }
    if(regs.size() > 0)
        writeTabbedLine("addu $sp, $sp, " + std::to_string(regs.size()*4));
    // std::cout << "STACK FRAMEEEE" << std::endl;
}

void CodeGen::generateHeaderFuncs(){
    writeLine(generate_getChar());
    writeLine(generate_halt());
    writeLine(generate_printb());
    writeLine(generate_printc());
    writeLine(generate_printi());
    writeLine(generate_prints());
    writeLine(generate_error());
}

