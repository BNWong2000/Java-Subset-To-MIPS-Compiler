#include <iostream>
#include <string>
#include <vector>

#include "ast.hpp"

Prog::~Prog(){};

void Prog::print() {
    std::cout << "Prog" << std::endl;
};

void AST::addChild(AST *child){
    std::cout << "adding child \n" << std::endl;
    children.push_back(child);
}

void AST::addSibling(AST *theSibling){
    sibling = theSibling;
}


//-------------------------------------------------

Statement::~Statement(){};

void Statement::print() {
    std::cout << "Statement" << std::endl;
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

void Expression::print() {
    std::cout << "Expression" << std::endl;
};

void Expression::setAsIdentifier(std::string myName){
    name = myName;
    theType = identifier;
};

void Expression::setAsNumber(int myNumber){
    num = myNumber;
    theType = number;
};

void Expression::setAsString(std::string *literal){
    name = *literal;
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

void Declaration::print() {
    std::cout << "Declaration" << std::endl;
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

