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
    functionCall,
    actual
};

enum Decl{
    function,
    variable,
    parameter
};

class AST {
private:
    std::vector <AST *> children;
    AST *sibling;

public:
    void addChild();
    void print();
    
};

class Prog : public AST{
private:
    std::string fileName;
public:
    Prog(std::string name) : fileName(name){}
};

class Statement : public AST{
private:
    Stmt theType;
public:    
};

class Expression : public AST{
private:
    Expr theType;
public:
};

class Declaration : public AST{
private:
    Decl theType;
public:

};

#endif
