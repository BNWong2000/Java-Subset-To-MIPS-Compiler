#include <iostream>
#include <string>
#include <vector>

#include "ast.hpp"


void AST::printProg(int indentLvl) {
    // formats the printing of the program (practically, the indentation should never be anything other than 0)
    std::cout << "├";
    for(int i = 0; i < indentLvl; i++){
        std::cout << "|    ";
    }
    std::cout << "{ Program: " << fileName << " }" << std::endl;
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void AST::printProgWithoutChildren(){
    std::cout << "{ Program: " << fileName << " }" << std::endl;
};

void AST::addChild(AST *child){
    // std::cout << "adding child \n" << std::endl;
    children.push_back(child);
}

void AST::addSibling(AST *theSibling){
    sibling = theSibling;
}


//-------------------------------------------------

void AST::printStmt(int indentLvl) {
    
    // Formats the printing of the outermost children. adds proper spacing
    if(indentLvl > 0){
        for(int i = 1; i < indentLvl; i++){
            std::cout << "|     ";
        }
        std::cout << "├----";
    }
    
    // prints out the type
    switch (theStmtType){
        case ifStmt:
            std::cout << "If statement";
            break;
        case ifElseStmt:
            std::cout << "If-else statement";
            break;
        case assignment:
            std::cout << "Assignment";
            break;
        case nullType:
            std::cout << "Null statement";
            break;
        case returnStmt:
            std::cout << "Return statement";
            break;
        case whileStmt:
            std::cout << "While statement";
            break;
        case breakStmt:
            std::cout << "Break statement";
            break;
        case blockStmt:
            std::cout << "Block";
            break;
        case funcCallStmt:
            std::cout << "Function call";
            break;
        case emptyBlockStmt:
            std::cout << "Empty block";
            break;
        default:
        ;
    } 

    // prints out the line number
    std::cout << " { line: " << lineNo << " }" << std::endl;

    // prints out the remaining children of this node
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void AST::printStmtWithoutChildren(){
    // prints out the type
    switch (theStmtType){
        case ifStmt:
            std::cout << "If statement";
            break;
        case ifElseStmt:
            std::cout << "If-else statement";
            break;
        case assignment:
            std::cout << "Assignment";
            break;
        case nullType:
            std::cout << "Null statement";
            break;
        case returnStmt:
            std::cout << "Return statement";
            break;
        case whileStmt:
            std::cout << "While statement";
            break;
        case breakStmt:
            std::cout << "Break statement";
            break;
        case blockStmt:
            std::cout << "Block";
            break;
        case funcCallStmt:
            std::cout << "Function call";
            break;
        case emptyBlockStmt:
            std::cout << "Empty block";
            break;
        default:
        ;
    } 

    // prints out the line number
    std::cout << " { line: " << lineNo << " }" << std::endl;
};


void AST::setAsIf(AST *ex, AST *ifBlock){
    theNode = statement;
    addChild(ex);
    addChild(ifBlock);
    theStmtType = ifStmt;
};

void AST::setAsIfElse(AST *ex, AST *ifBlock, AST *elseBlock){
    theNode = statement;
    addChild(ex);
    addChild(ifBlock);
    addChild(elseBlock);
    theStmtType = ifElseStmt;
};

void AST::setAsAssignment(AST *identifier, AST *assignExp){
    theNode = statement;
    addChild(identifier);
    addChild(assignExp);
    theStmtType = assignment;
};

void AST::setAsNull(){
    theNode = statement;
    theStmtType = nullType;
};

void AST::setAsReturn(){
    theNode = statement;
    theStmtType = returnStmt;
};

void AST::setAsReturn(AST *ex){
    theNode = statement;
    addChild(ex);
    theStmtType = returnStmt;
};

void AST::setAsWhile(AST *ex, AST *block){
    theNode = statement;
    addChild(ex);
    addChild(block);
    theStmtType = whileStmt;
};

void AST::setAsBreak(){
    theNode = statement;
    theStmtType = breakStmt;
};

void AST::setAsBlock(AST *node){
    theNode = statement;
    addChild(node);
    theStmtType = blockStmt;
};

void AST::setAsFunctionStatement(AST *functionCall){
    theNode = statement;
    addChild(functionCall);
    theStmtType = funcCallStmt;
};

void AST::setAsEmptyBlock(){
    theNode = statement;
    theStmtType = emptyBlockStmt;
}



//-------------------------------------------------


void AST::printExprWithoutChildren() {
    // Prints out the type, and, if necessary, other details
    switch (theExprType){
        case identifier:
            std::cout << "Identifier { Name: " << "\"" << name << "\",";
            break;
        case number:
            std::cout << "number { Value: " << num << ",";
            break;
        case stringLit:
            {
                std::cout << "String Literal { Value: ";
                auto nullChar = name.find('\0');
                if(nullChar != std::string::npos){
                    std::cout << name.substr(0, (int) nullChar) << "\\x00" << name.substr(((int) nullChar) + 1, name.size()-((int) nullChar));
                }else{
                    std::cout << name;
                }
                std::cout << ",";
                break;
            }
        case boolLit:
            {std::string boolVal;
            boolVal = num == 1 ? "True" : "False";
            std::cout << "Boolean Literal { Value: " << boolVal << ",";
            break;}
        case unary:
            {
                std::cout << "Unary { Operator: ";
                switch(theOp){
                    case op_SUB:
                        std::cout << "\'-\',";
                        break;
                    case op_NOT:
                        std::cout << "\'!\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case relational:
            {
                std::cout << "Relation { Operator: ";
                switch(theOp){  
                    case op_LT:
                        std::cout << "\'<\',";
                        break;
                    case op_GT:
                        std::cout << "\'>\',";
                        break;
                    case op_GE:
                        std::cout << "\'>=\',";
                        break;
                    case op_LE:
                        std::cout << "\'<=\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case equality:
            {
                std::cout << "Equality { Operator: ";
                switch(theOp){
                    case op_EQ:
                        std::cout << "\'==\',";
                        break;
                    case op_NEQ:
                        std::cout << "\'!=\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case conditional:
            {
                std::cout << "Conditional { Operator: ";
                switch(theOp){
                    case op_AND:
                        std::cout << "\'&&\',";
                        break;
                    case op_OR:
                        std::cout << "\'||\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case arithmetic:
            {
                std::cout << "Arithmetic { Operator: ";
                switch(theOp){
                    case op_ADD:
                        std::cout << "\'+\',";
                        break;
                    case op_SUB:
                        std::cout << "\'-\',";
                        break;
                    case op_MULT:
                        std::cout << "\'*\',";
                        break;
                    case op_DIV:
                        std::cout << "\'/\',";
                        break;
                    case op_MOD:
                        std::cout << "\'%\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case functionCall:
            std::cout << "Function Call {" ;
            break;
        // case assignExpr:
        //     std::cout << "Assignment Expression {";
        //     break;
        default:
            break;
    }

    // Prints out the line number
    std::cout << " line: " << lineNo << " }" << std::endl;
};

void AST::printExpr(int indentLvl) {
    // Formats the spacing of the tree properly
    if(indentLvl > 0){
        for(int i = 1; i < indentLvl; i++){
            std::cout << "|     ";
        }
        std::cout << "├----";
    }

    // Prints out the type, and, if necessary, other details
    switch (theExprType){
        case identifier:
            std::cout << "Identifier { Name: " << "\"" << name << "\",";
            break;
        case number:
            std::cout << "number { Value: " << num << ",";
            break;
        case stringLit:
            {
                std::cout << "String Literal { Value: ";
                auto nullChar = name.find('\0');
                if(nullChar != std::string::npos){
                    std::cout << name.substr(0, (int) nullChar) << "\\x00" << name.substr(((int) nullChar) + 1, name.size()-((int) nullChar));
                }else{
                    std::cout << name;
                }
                std::cout << ",";
                break;
            }
        case boolLit:
            {std::string boolVal;
            boolVal = num == 1 ? "True" : "False";
            std::cout << "Boolean Literal { Value: " << boolVal << ",";
            break;}
        case unary:
            {
                std::cout << "Unary { Operator: ";
                switch(theOp){
                    case op_SUB:
                        std::cout << "\'-\',";
                        break;
                    case op_NOT:
                        std::cout << "\'!\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case relational:
            {
                std::cout << "Relation { Operator: ";
                switch(theOp){  
                    case op_LT:
                        std::cout << "\'<\',";
                        break;
                    case op_GT:
                        std::cout << "\'>\',";
                        break;
                    case op_GE:
                        std::cout << "\'>=\',";
                        break;
                    case op_LE:
                        std::cout << "\'<=\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case equality:
            {
                std::cout << "Equality { Operator: ";
                switch(theOp){
                    case op_EQ:
                        std::cout << "\'==\',";
                        break;
                    case op_NEQ:
                        std::cout << "\'!=\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case conditional:
            {
                std::cout << "Conditional { Operator: ";
                switch(theOp){
                    case op_AND:
                        std::cout << "\'&&\',";
                        break;
                    case op_OR:
                        std::cout << "\'||\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case arithmetic:
            {
                std::cout << "Arithmetic { Operator: ";
                switch(theOp){
                    case op_ADD:
                        std::cout << "\'+\',";
                        break;
                    case op_SUB:
                        std::cout << "\'-\',";
                        break;
                    case op_MULT:
                        std::cout << "\'*\',";
                        break;
                    case op_DIV:
                        std::cout << "\'/\',";
                        break;
                    case op_MOD:
                        std::cout << "\'%\',";
                        break;
                    default:
                        break;
                }
                break;
            }
        case functionCall:
            std::cout << "Function Call {" ;
            break;
        // case assignExpr:
        //     std::cout << "Assignment Expression {";
        //     break;
        default:
            break;
    }

    // Prints out the line number
    std::cout << " line: " << lineNo << " }" << std::endl;

    // Prints out the children of the node. 
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void AST::setAsIdentifier(std::string myName){
    theNode = expression;
    name = myName;
    theExprType = identifier;
};

void AST::setAsNumber(int myNumber){
    theVar = var_INT;
    theNode = expression;
    num = myNumber;
    theExprType = number;
};

void AST::setAsString(std::string *literal){
    theVar = var_STRING;
    theNode = expression;
    name = *literal;
    theExprType = stringLit;
};

void AST::setAsBool(bool isTrue){
    theNode = expression;
    theVar = var_BOOL;
    if(isTrue){
        num = 1;
    }else{
        num = 0;
    }
    theExprType = boolLit;
};


void AST::setAsUnary(Operators op, AST *ex){
    theNode = expression;
    theOp = op;
    addChild(ex);
    theExprType = unary;
};

void AST::setAsRelational(AST *e1, Operators op, AST *e2){
    theVar = var_BOOL;
    theNode = expression;
    addChild(e1);
    addChild(e2);
    theOp = op;
    theExprType = relational;
};

void AST::setAsEquality(AST *e1, Operators op, AST *e2){
    theVar = var_BOOL;
    theNode = expression;
    addChild(e1);
    addChild(e2);
    theOp = op;
    theExprType = equality;
};

void AST::setAsConditional(AST *e1, Operators op, AST *e2){
    theVar = var_BOOL;
    theNode = expression;
    addChild(e1);
    addChild(e2);
    theOp = op;
    theExprType = conditional;
};

void AST::setAsArithmetic(AST *e1, Operators op, AST *e2){
    theVar = var_INT;
    theNode = expression;
    addChild(e1);
    addChild(e2);
    theOp = op;
    theExprType = arithmetic;
};

void AST::setAsFunctionCall(AST *id){
    theNode = expression;
    addChild(id);
    theExprType = functionCall;
};

void AST::setAsFunctionCall(AST *id, AST *args){
    theNode = expression;
    addChild(id);
    addChild(args);
    theExprType = functionCall;
};

// void AST::setAsAssignment(AST *assignStmt){
//     theNode = expression;
//     addChild(assignStmt);
//     theExprType = assignExpr;
// };

//-------------------------------------------------

void AST::printDeclWithoutChildren() {
    // Prints out the type and any other necessary details
    switch(theDeclType){
        case declarator: {
            std::cout << "Function Declarator { Return type: ";
            break;
        }
        case function:
        {
            std::cout << "Function { Return Type: ";
            switch(theVar){
                case var_BOOL:
                    std::cout << "Boolean,";
                    break;
                case var_INT:
                    std::cout << "Integer,";
                    break;
                case var_STRING:
                    std::cout << "String,";
                    break;
                case var_VOID:
                    std::cout << "Void,";
                    break;
                default:
                    std::cerr << "Error: illegal Type" << std::endl;
            }
            break;
        }
        case mainFunction:
            std::cout << "Main Function {";
            break;
        case functionHeader:
            {
                std::cout << "Function Header { Return type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        case variable:
            {
                std::cout << "Variable { Type: ";
            switch(theVar){
                case var_BOOL:
                    std::cout << "Boolean,";
                    break;
                case var_INT:
                    std::cout << "Integer,";
                    break;
                case var_STRING:
                    std::cout << "String,";
                    break;
                case var_VOID:
                    std::cout << "Void,";
                    break;
                default:
                    std::cerr << "Error: illegal Type" << std::endl;
            }
            break;
        }
        case globalVariable:
            {
                std::cout << "Global variable { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        case parameter:
            {
                std::cout << "Parameter { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        case typeDecl:
            {
                std::cout << "Type Declaration { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        default:
        ;
    }

    // prints out the line number
    std::cout << " line: " << lineNo << " }" << std::endl;
};

void AST::printDecl(int indentLvl) {
    // Ensures proper spacing when printing. 
    if(indentLvl > 0){
        for(int i = 1; i < indentLvl; i++){
            std::cout << "|     ";
        }
        std::cout << "├----";
    }
    // Prints out the type and any other necessary details
    switch(theDeclType){
        case declarator:
            std::cout << "Function Declarator {";
            break;
        case function: {
            std::cout << "Function { Return Type: ";
            switch(theVar){
                case var_BOOL:
                    std::cout << "Boolean,";
                    break;
                case var_INT:
                    std::cout << "Integer,";
                    break;
                case var_STRING:
                    std::cout << "String,";
                    break;
                case var_VOID:
                    std::cout << "Void,";
                    break;
                default:
                    std::cerr << "Error: illegal Type" << std::endl;
            }
            break;
        }
        case mainFunction:
            std::cout << "Main Function {";
            break;
        case functionHeader:
            {
                std::cout << "Function Header { Return type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        case variable:
            {
                std::cout << "Variable { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
            }
            break;
        }
        case globalVariable:
            {
                std::cout << "Global variable { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
            break;
            }
        case parameter:
            {
                std::cout << "Parameter { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        case typeDecl:
            {
                std::cout << "Type Declaration { Type: ";
                switch(theVar){
                    case var_BOOL:
                        std::cout << "Boolean,";
                        break;
                    case var_INT:
                        std::cout << "Integer,";
                        break;
                    case var_STRING:
                        std::cout << "String,";
                        break;
                    case var_VOID:
                        std::cout << "Void,";
                        break;
                    default:
                        std::cerr << "Error: illegal Type" << std::endl;
                }
                break;
            }
        default:
        ;
    }

    // prints out the line number
    std::cout << " line: " << lineNo << " }" << std::endl;

    // Prints out the children of the node. 
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void AST::setAsDeclarator(AST *id){
    theNode = declaration;
    addChild(id);
    theDeclType = declarator;
};

void AST::setAsDeclarator(AST *id, AST *params){
    theNode = declaration;
    addChild(id);
    addChild(params);
    theDeclType = declarator;
};

void AST::setAsFunction(AST *block){
    theNode = declaration;
    addChild(block);
    theDeclType = function;
};

void AST::setAsMainFunction(AST *dec, AST *block){
    theNode = declaration;
    addChild(dec);
    addChild(block);
    theDeclType = mainFunction;
}

void AST::setAsFunctionHeader(AST *dec, Variables varType){
    theNode = declaration;
    addChild(dec);
    theVar = varType;
    theDeclType = functionHeader;
};

void AST::setAsVariable(AST *id, Variables varType){
    theNode = declaration;
    addChild(id);
    theVar = varType;
    theDeclType = variable;
};

void AST::setAsGlobalVariable(){
    theDeclType = globalVariable;
};

void AST::setAsParameter(Variables varType, AST *ex){
    theNode = declaration;
    theVar = varType;
    addChild(ex);
    theDeclType = parameter;
};

void AST::setAsType(Variables varType){
    theNode = declaration;
    theVar = varType;
    theDeclType = typeDecl;
};

void AST::print(int indentLvl){
    switch (theNode){
        case prog:
            printProg(indentLvl);
            break;
        case statement:
            printStmt(indentLvl);
            break;
        case expression:
            printExpr(indentLvl);
            break;
        case declaration:
            printDecl(indentLvl);
            break;
    };
}

void AST::printWithoutChildren(){
    switch (theNode){
        case prog:
            printProgWithoutChildren();
            break;
        case statement:
            printStmtWithoutChildren();
            break;
        case expression:
            printExprWithoutChildren();
            break;
        case declaration:
            printDeclWithoutChildren();
            break;
    };
}

