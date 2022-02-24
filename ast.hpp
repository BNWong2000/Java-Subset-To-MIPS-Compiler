#pragma once
#ifndef AST_HPP
#define AST_HPP

#include <iostream>
#include <string>
#include <vector>


enum Operators
{
    op_ADD,
    op_SUB,
    op_MULT,
    op_DIV,
    op_MOD,
    op_LT,
    op_GT,
    op_GE,
    op_LE,
    op_EQ,
    op_NEQ,
    op_NOT,
    op_AND,
    op_OR
};

enum Variables
{
    var_INT,
    var_BOOL,
    var_VOID,
    var_STRING
};

enum Stmt{
    ifStmt,
    ifElseStmt,
    assignment,
    nullType,
    returnStmt,
    whileStmt,
    breakStmt,
    blockStmt
};

enum Expr{
    identifier,
    number,
    unary,
    relational,
    equality,
    conditional,
    arithmetic,
    functionCall,
    assignExpr,
};

enum Decl{
    function,
    variable,
    parameter
};

class AST {
protected:
    std::vector <AST *> children;
    AST *sibling;

public:
    AST() = default;

    virtual ~AST(){
    	for(auto child : children){
	        delete child;
	    }
	    children.clear();
    }

    
    void addChild(AST* child);
    void addSibling(AST* theSibling);
    virtual void print() = 0;
    
};

class Prog : public AST{
private:
    std::string fileName;
public:
    virtual ~Prog();
    Prog(std::string name) : fileName(name){}    
    void print() override;
};

// Forward Declaration of Declaration and Expression
class Declaration;
class Expression;

class Statement : public AST{
private:
    Stmt theType;
public:    
    virtual ~Statement();
    Statement(){}    
    Statement(Stmt stmtType) : theType(stmtType){}    
    
    void setAsIf(Expression *ex, Statement *ifBlock);
    void setAsIfElse(Expression *ex, Statement *ifBlock, Statement *elseBlock);
    void setAsAssignment(Expression *identifier, Expression *assignExp);
    void setAsNull();
    void setAsReturn(Expression *ex);
    void setAsWhile(Expression *ex, Statement *block);
    void setAsBreak();
    void setAsBlock(Statement *stat);
    void setAsBlock(Declaration *decl);
    
    void print() override;
};

class Expression : public AST{
private:
    Expr theType;
    Operators theOp;
    std::string name;
    int num;
public:
    virtual ~Expression();
    Expression(){}
    Expression(Expr exprType) : theType(exprType){}
    
    void setAsIdentifier(std::string myName);
    void setAsNumber(int myNumber);
    void setAsUnary(Operators op, Expression *ex);
    void setAsRelational(Expression *e1, Operators op, Expression *e2);
    void setAsEquality(Expression *e1, Operators op, Expression *e2);
    void setAsConditional(Expression *e1, Operators op, Expression *e2);
    void setAsArithmetic(Expression *e1, Operators op, Expression *e2);
    void setAsFunctionCall(std::string myName);
    void setAsFunctionCall(std::string myName, Expression *args);
    void setAsAssignment(Statement *assignStmt);
    
    void print() override;
};

class Declaration : public AST{
private:
    Decl theType;
    Variables theVar;
    std::string name;
public:
    virtual ~Declaration();
    Declaration(){}
    Declaration(Decl declType) : theType(declType){}
    
    void setAsFunction(std::string myName, Declaration *dec);
    void setAsVariable(Expression *id, Variables varType);
    void setAsParameter(Variables varType, Expression *ex); //type identifier
    // void setAsParameterList(std::vector<Declaration *> params);

    void print() override;
};

#endif
