#pragma once
#ifndef AST_HPP
#define AST_HPP

#include <iostream>
#include <string>
#include <vector>

// All the arithmetic and logical operators
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

// Variable types (explicit and implicit)
enum Variables
{
    var_INT,
    var_BOOL,
    var_VOID,
    var_STRING
};

// Statement types - to be used to define the type of statement for each class instance
enum Stmt
{
    ifStmt,
    ifElseStmt,
    assignment,
    nullType,
    returnStmt,
    whileStmt,
    breakStmt,
    blockStmt,
    funcCallStmt,
    emptyBlockStmt
};

// Expression types - to be used to define the type of expression for each class instance
enum Expr
{
    identifier,
    number,
    stringLit,
    boolLit,
    unary,
    relational,
    equality,
    conditional,
    arithmetic,
    functionCall,
    assignExpr,
};

// Declaration types - to be used to define the type of declaration for each class instance
enum Decl
{
    declarator,
    mainFunction,
    function,
    functionHeader,
    variable,
    globalVariable,
    parameter,
    typeDecl
};

// Parent class.
class AST
{
protected:
    // A vector for all the children of a node
    std::vector<AST *> children;

    // A pointer to the sibling of the node
    AST *sibling = nullptr;

public:
    AST() = default;

    virtual ~AST()
    {
        for (auto child : children)
        {
            delete child;
        }
        children.clear();
    }

    void addChild(AST *child);
    void addSibling(AST *theSibling);

    std::vector<AST *>& getChildren(){
        return children;
    }

    bool hasSibling()
    {
        return sibling != nullptr;
    }

    AST *getSibling()
    {
        return sibling;
    }

    // Pure virtual function to be defined by the children classes
    virtual void print(int indentLvl) = 0;
    virtual void printWithoutChildren() = 0;
};

class Prog : public AST
{
private:
    // Top level node, which stores the file name.
    std::string fileName;

public:
    virtual ~Prog();
    Prog(std::string name) : fileName(name) {}
    void print(int indentLvl) override;
    void printWithoutChildren() override;
};

// Forward Declaration of Declaration and Expression
class Declaration;
class Expression;

// Node which stores information on statements
class Statement : public AST
{
private:
    Stmt theType;

    // Line number of the statement, for printing/debugging
    int lineNo;

public:
    virtual ~Statement();
    Statement(int line) : lineNo(line) {}
    Statement(Stmt stmtType) : theType(stmtType) {}

    // The following functions are meant to be called after the constructor is called.
    // They set the type, and add any mandatory children
    void setAsIf(Expression *ex, Statement *ifBlock);
    void setAsIfElse(Expression *ex, Statement *ifBlock, Statement *elseBlock);
    void setAsAssignment(Expression *identifier, Expression *assignExp);
    void setAsNull();
    void setAsReturn();
    void setAsReturn(Expression *ex);
    void setAsWhile(Expression *ex, Statement *block);
    void setAsBreak();
    // This setAsBlock allows for any type of node to be added to a block.
    void setAsBlock(AST *node);
    void setAsBlock(Statement *stat);
    void setAsBlock(Declaration *decl);
    void setAsFunctionStatement(Expression *functionCall);
    void setAsEmptyBlock();

    void print(int indentLvl) override;
    void printWithoutChildren() override;
};

class Expression : public AST
{
private:
    Expr theType;

    // Expressions (arithmetic and logical) often require an operator
    Operators theOp;

    // a string, to store information for identifiers, or strings.
    std::string name;

    // an int to store information for integer literals
    int num;
    int lineNo;

public:
    virtual ~Expression();
    Expression(int line) : lineNo(line) {}
    Expression(Expr exprType) : theType(exprType) {}

    // The following functions are meant to be called after the constructor is called.
    // They set the type, and add any mandatory children
    void setAsIdentifier(std::string myName);
    void setAsNumber(int myNumber);
    void setAsString(std::string *literal);
    void setAsBool(bool isTrue);
    void setAsUnary(Operators op, Expression *ex);
    void setAsRelational(Expression *e1, Operators op, Expression *e2);
    void setAsEquality(Expression *e1, Operators op, Expression *e2);
    void setAsConditional(Expression *e1, Operators op, Expression *e2);
    void setAsArithmetic(Expression *e1, Operators op, Expression *e2);
    void setAsFunctionCall(Expression *id);
    void setAsFunctionCall(Expression *id, Expression *args);
    void setAsAssignment(Statement *assignStmt);

    std::string getName()
    {
        return name;
    }

    int getNum()
    {
        return num;
    }

    void print(int indentLvl) override;
    void printWithoutChildren() override;
};

class Declaration : public AST
{
private:
    Decl theType;

    // Variable to store information on variable types for certain declarations
    Variables theVar;
    int lineNo;

public:
    virtual ~Declaration();
    Declaration(int line) : lineNo(line) {}
    Declaration(Decl declType) : theType(declType) {}

    // The following functions are meant to be called after the constructor is called.
    // They set the type, and add any mandatory children
    void setAsDeclarator(Expression *id);
    void setAsDeclarator(Expression *id, Declaration *params);
    void setAsFunction(Declaration *dec, Statement *block);
    void setAsMainFunction(Declaration *dec, Statement *block);
    void setAsFunctionHeader(Declaration *dec, Variables varType);
    void setAsVariable(Expression *id, Variables varType);
    void setAsGlobalVariable();
    void setAsParameter(Variables varType, Expression *ex); // type identifier
    void setAsType(Variables varType);

    Variables getVar()
    {
        return theVar;
    }
    void print(int indentLvl) override;
    void printWithoutChildren() override;
};

#endif
