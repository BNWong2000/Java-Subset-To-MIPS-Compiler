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

class AST;

class Prog;

class Statement;
class Block;
class IfStatement;
class IfElseStatement;
class AssignStatement;
class NullStatement;
class ReturnStatement;
class WhileStatement;
class BreakStatement;

class Expression;
class Identifier;
class Number;
class Arithmetic;
class Comparison;
class Actuals;
class FunctionCalls;

class Declaration;
class FunctDecl;
class VariableDecl;
class Param;

class AST
{
protected:
    std::vector<AST *> children;

    virtual void addChild(AST *newChild) = 0; // Pure virtual function
public:
    AST() = default;

    virtual ~AST()
    {
        for (auto it : children)
        {
            delete it;
        }

        children.clear();
    }

    virtual void print() = 0;
};

class Prog : public AST
{
protected:
    std::string file;
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    Prog(std::string fileName) : file(fileName){}

    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Prog" << std::endl;
        for(auto child : children){
            child->print();
        }
    }
};

class Statement : public AST
{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};

class Expression : public AST
{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Expression" << std::endl;
    }
};

class Declaration : public AST
{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};


class IfStatement : public Statement {
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};

class IfElseStatement : public Statement{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};

class AssignStatement : public Statement{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};
class NullStatement : public Statement{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};

class ReturnStatement : public Statement{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};

class WhileStatement : public Statement{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};

class BreakStatement : public Statement{
protected:
    void addChild(AST *child) override
    {
        children.push_back(child);
    }

public:
    void addNode(AST *node)
    {
        addChild(node);
    }

    void print() override
    {
        std::cout << "\t"
                  << "Statement" << std::endl;
    }
};


class Identifier : public Expression{
private:
    std::string id;

public:
    Identifier(std::string myId) : id(myId){}
};

class Number : public Expression {
private: 
    int num;

public:
    Number(int myNum) : num(myNum){}
};

class Arithmetic : public Expression {
private:
    Operators op;


public:
    Arithmetic(Operators myOp, Expression e1, Expression e2);
};


class Comparison : public Expression {
private: 
    Operators op;


public:
    Comparison(Operators myOp, Expression e1, Expression e2);
};

class Actuals;
class FunctionCalls;



#endif
