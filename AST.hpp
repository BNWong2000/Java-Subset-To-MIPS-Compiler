#pragma once
#ifndef AST_HPP
#define AST_HPP

#include <iostream>
#include <string>

enum Operators{
    ADD, SUB, MULT, DIV, MOD,
    LT, GT, GE, LE, EQ, NEQ, NOT,
    AND, OR
}

enum Variables{
    INT, BOOL, VOID, STRING
}

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
	class BreakStatemnt;

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



class AST {
protected:
    std::vector <AST *> children;

    virtual void addChild(AST *newChild) = 0; // Pure virtual function
public:
    AST() = default;

    virtual ~AST(){
	for(auto it : children){
            delete it;
	}

	children.clear();
    }

    virtual void print() = 0;

}

class Prog : public AST{
protected:
    void addChild(AST *child) override {
	children.push_back(child);
    }

public:
    void addNode(AST *node){
        addChild(node);
    }
    
    void print() override{
        std::cout << "\t" <<"Prog" << std::endl;
    }
}












#endif

