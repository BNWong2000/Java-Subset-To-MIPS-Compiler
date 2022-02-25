#include <iostream>
#include <string>
#include <vector>

#include "ast.hpp"

Prog::~Prog(){};

void Prog::print(int indentLvl) {
    std::cout << "├";
    for(int i = 0; i < indentLvl; i++){
        std::cout << "|    ";
    }
    std::cout << "{ Program: " << fileName << " }" << std::endl;
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void AST::addChild(AST *child){
    // std::cout << "adding child \n" << std::endl;
    children.push_back(child);
}

void AST::addSibling(AST *theSibling){
    sibling = theSibling;
}


//-------------------------------------------------

Statement::~Statement(){};

void Statement::print(int indentLvl) {
    
    if(indentLvl > 0){
        for(int i = 1; i < indentLvl; i++){
            std::cout << "|     ";
        }
        std::cout << "├----";
    }
    

    switch (theType){
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

    std::cout << " { line: " << lineNo << " }" << std::endl;
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void Statement::setAsIf(Expression *ex, Statement *ifBlock){
    addChild(ex);
    addChild(ifBlock);
    theType = ifStmt;
};

void Statement::setAsIfElse(Expression *ex, Statement *ifBlock, Statement *elseBlock){
    addChild(ex);
    addChild(ifBlock);
    addChild(elseBlock);
    theType = ifElseStmt;
};

void Statement::setAsAssignment(Expression *identifier, Expression *assignExp){
    addChild(identifier);
    addChild(assignExp);
    theType = assignment;
};

void Statement::setAsNull(){
    theType = nullType;
};

void Statement::setAsReturn(){
    theType = returnStmt;
};

void Statement::setAsReturn(Expression *ex){
    addChild(ex);
    theType = returnStmt;
};

void Statement::setAsWhile(Expression *ex, Statement *block){
    addChild(ex);
    addChild(block);
    theType = whileStmt;
};

void Statement::setAsBreak(){
    theType = breakStmt;
};

void Statement::setAsBlock(Statement *stat){
    addChild(stat);
    theType = blockStmt;
};

void Statement::setAsBlock(Declaration *decl){
    addChild(decl);
    theType = blockStmt;
};

void Statement::setAsFunctionStatement(Expression *functionCall){
    addChild(functionCall);
    theType = funcCallStmt;
};

void Statement::setAsEmptyBlock(){
    theType = emptyBlockStmt;
}



//-------------------------------------------------

Expression::~Expression(){};

void Expression::print(int indentLvl) {
    
    if(indentLvl > 0){
        for(int i = 1; i < indentLvl; i++){
            std::cout << "|     ";
        }
        std::cout << "├----";
    }

    switch (theType){
        case identifier:
            std::cout << "Identifier { Name: " << "\"" << name << "\",";
            break;
        case number:
            std::cout << "number { Value: " << num << ",";
            break;
        case stringLit:
            std::cout << "String Literal { Value: "  << name << ",";
            break;
        case boolLit:
            {std::string boolVal;
            boolVal = num == 1 ? "True" : "False";
            std::cout << "Boolean Literal { Value: " << boolVal << ",";
            break;}
        case unary:
            {std::cout << "Unary { Operator: ";
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
            break;}
        case relational:
            {std::cout << "Relation { Operator: ";
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
            break;}
        case equality:
            {std::cout << "Equality { Operator: ";
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
            break;}
        case conditional:
            {std::cout << "Conditional { Operator: ";
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
            break;}
        case arithmetic:
            {std::cout << "Arithmetic { Operator: ";
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
            break;}
        case functionCall:
            std::cout << "Function Invocation {" ;
            break;
        case assignExpr:
            std::cout << "Assignment {";
            break;
        default:
            break;
    }

    std::cout << " line: " << lineNo << " }" << std::endl;
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void Expression::setAsIdentifier(std::string myName){
    name = myName;
    theType = identifier;
};

void Expression::setAsNumber(int myNumber){
    num = myNumber;
    theType = number;
};

void Expression::setAsString(std::string literal){
    name = literal;
    theType = stringLit;
};

void Expression::setAsBool(bool isTrue){
    if(isTrue){
        num = 1;
    }else{
        num = 0;
    }
    theType = boolLit;
};


void Expression::setAsUnary(Operators op, Expression *ex){
    theOp = op;
    addChild(ex);
    theType = unary;
};

void Expression::setAsRelational(Expression *e1, Operators op, Expression *e2){
    addChild(e1);
    addChild(e2);
    theOp = op;
    theType = relational;
};

void Expression::setAsEquality(Expression *e1, Operators op, Expression *e2){
    addChild(e1);
    addChild(e2);
    theOp = op;
    theType = equality;
};

void Expression::setAsConditional(Expression *e1, Operators op, Expression *e2){
    addChild(e1);
    addChild(e2);
    theOp = op;
    theType = conditional;
};

void Expression::setAsArithmetic(Expression *e1, Operators op, Expression *e2){
    addChild(e1);
    addChild(e2);
    theOp = op;
    theType = arithmetic;
};

void Expression::setAsFunctionCall(Expression *id){
    addChild(id);
    theType = functionCall;
};

void Expression::setAsFunctionCall(Expression *id, Expression *args){
    addChild(id);
    addChild(args);
    theType = functionCall;
};

void Expression::setAsAssignment(Statement *assignStmt){
    addChild(assignStmt);
    theType = assignExpr;
};



//-------------------------------------------------

Declaration::~Declaration(){};

void Declaration::print(int indentLvl) {
    
    if(indentLvl > 0){
        for(int i = 1; i < indentLvl; i++){
            std::cout << "|     ";
        }
        std::cout << "├----";
    }

    switch(theType){
        case declarator:
            std::cout << "Function Declarator {";
            break;
        case function:
            std::cout << "Function {";
            break;
        case functionHeader:
            {std::cout << "Function Header { Return type: ";
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
            break;}
        case variable:
            {std::cout << "Variable { Type: ";
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
            break;}
        case parameter:
            {std::cout << "Parameter { Type: ";
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
            break;}
        case typeDecl:
            {std::cout << "Type Declaration { Type: ";
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
            break;}
        default:
        ;
    }

    std::cout << " line: " << lineNo << " }" << std::endl;
    for(auto child : children){
        child->print(indentLvl + 1);
    }
};

void Declaration::setAsDeclarator(Expression *id){
    addChild(id);
    theType = declarator;
};

void Declaration::setAsDeclarator(Expression *id, Declaration *params){
    addChild(id);
    addChild(params);
    theType = declarator;
};

void Declaration::setAsFunction(Declaration *dec, Statement *block){
    addChild(dec);
    addChild(block);
    theType = function;
};

void Declaration::setAsFunctionHeader(Declaration *dec, Variables varType){
    addChild(dec);
    theVar = varType;
    theType = functionHeader;
};

void Declaration::setAsVariable(Expression *id, Variables varType){
    addChild(id);
    theVar = varType;
    theType = variable;
};

void Declaration::setAsParameter(Variables varType, Expression *ex){
    theVar = varType;
    addChild(ex);
    theType = parameter;
};

void Declaration::setAsType(Variables varType){
    theVar = varType;
    theType = typeDecl;
};

