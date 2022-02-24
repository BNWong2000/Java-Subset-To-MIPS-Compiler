#pragma once
#ifndef AST_HPP
#define AST_HPP

#include <iostream>
#include <string>
#include <vector>


enum Operators
{
    ADD,
    SUB,
    MULT,
    DIV,
    MOD,
    LT,
    GT,
    GE,
    LE,
    EQ,
    NEQ,
    NOT,
    AND,
    OR
};

enum Variables
{
    INT,
    BOOL,
    VOID,
    STRING
};

enum Stmt{
    ifStmt,
    ifElseStmt,
    assignment,
    null,
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
    arithmetic,
    functionCall
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
    int number;
public:
    virtual ~Expression();
    Expression(Expr exprType) : theType(exprType){}
    
    void setAsIdentifier(std::string myName);
    void setAsNumber(int myNumber);
    void setAsUnary(Operators op, Expression *ex);
    void setAsRelational(Expression *e1, Operators op, Expression *e2);
    void setAsEquality(Expression *e1, Operators op, Expression *e2);
    void setAsArithmetic(Expression *e1, Operators op, Expression *e2);
    void setAsFunctionCall(std::string myName);
    void setAsFunctionCall(std::string myName, Expression *args);
    
    void print() override;
};

class Declaration : public AST{
private:
    Decl theType;
    std::string name;
public:
    virtual ~Declaration();
    Declaration(Decl declType) : theType(declType){}
    
    void setAsFunction(std::string myName, Declaration *dec);
    void setAsVariable(Expression id, Variables *varType);
    void setAsParameter(Variables varType, Expression *ex); //type identifier
    // void setAsParameterList(std::vector<Declaration *> params);

    void print() override;
};

#endif
