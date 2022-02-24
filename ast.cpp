#include <iostream>
#include <string>
#include <vector>

#include "ast.hpp"

Prog::~Prog(){};

void Prog::print() {
    std::cout << "Prog" << std::endl;
};

void AST::addChild(AST *child){
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

};

void Statement::setAsIfElse(Expression *ex, Statement *ifBlock, Statement *elseBlock){

};

void Statement::setAsAssignment(Expression *identifier, Expression *assignExp){

};

void Statement::setAsNull(){

};

void Statement::setAsReturn(Expression *ex){

};

void Statement::setAsWhile(Expression *ex, Statement *block){

};

void Statement::setAsBreak(){

};

void Statement::setAsBlock(Statement *stat){

};

void Statement::setAsBlock(Declaration *decl){

};



//-------------------------------------------------

Expression::~Expression(){};

void Expression::print() {
    std::cout << "Expression" << std::endl;
};

void Expression::setAsIdentifier(std::string myName){

};

void Expression::setAsNumber(int myNumber){

};

void Expression::setAsUnary(Operators op, Expression *ex){

};

void Expression::setAsRelational(Expression *e1, Operators op, Expression *e2){

};

void Expression::setAsEquality(Expression *e1, Operators op, Expression *e2){

};

void Expression::setAsArithmetic(Expression *e1, Operators op, Expression *e2){

};

void Expression::setAsFunctionCall(std::string myName){

};

void Expression::setAsFunctionCall(std::string myName, Expression *args){

};


//-------------------------------------------------

Declaration::~Declaration(){};

void Declaration::print() {
    std::cout << "Declaration" << std::endl;
};

void Declaration::setAsFunction(std::string myName, Declaration *dec){

};

void Declaration::setAsVariable(Expression id, Variables *varType){

};

void Declaration::setAsParameter(Variables varType, Expression *ex){

};

