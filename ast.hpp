#pragma once
#ifndef AST_HPP
#define AST_HPP

#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <unordered_map>
#include "regEnums.hpp"

class Semantic;
class SymEntry;

// All the arithmetic and logical operators
enum Operators {
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

inline std::string opToString(Operators op){
    switch (op){
        case op_ADD:    return "+";
        case op_SUB:    return "-";
        case op_MULT:   return "*";
        case op_DIV:    return "/";
        case op_MOD:    return "%";
        case op_LT:     return "<";
        case op_GT:     return ">";
        case op_GE:     return ">=";
        case op_LE:     return "<=";
        case op_EQ:     return "==";
        case op_NEQ:    return "!=";
        case op_NOT:    return "!";
        case op_AND:    return "&&";
        case op_OR:     return "||";
        default: return "invalid op.";
    }
}

// Variable types (explicit and implicit)
enum Variables {
    not_var,
    var_INT,
    var_BOOL,
    var_VOID,
    var_STRING,
};

inline std::string varToString(Variables var){
    switch (var){
        case var_INT: return "int";
        case var_BOOL: return "boolean";
        case var_VOID: return "void";
        case var_STRING: return "string";  
        default: return "invalid var type.";     
    }
}

// Statement types - to be used to define the type of statement for each class instance
enum Stmt {
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
enum Expr {
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
};

// Declaration types - to be used to define the type of declaration for each class instance
enum Decl {
    declarator,
    mainFunction,
    function,
    functionHeader,
    variable,
    globalVariable,
    parameter,
    typeDecl
};

enum NodeType {
    prog,
    statement,
    expression,
    declaration
};

// enum for if a node is connected to a while or if/else
// noneOfTheBelow means it isn't (default value)
enum ifWhileElseStuff{
    noneOfTheBelow,
    ifConditional,
    elseConditional,
    whileConditional,
    ifBlock,
    elseBlock,
    whileBlock

};

// Parent class.
class AST {
protected:
    // A vector for all the children of a node
    std::vector<AST *> children;

    // A pointer to the sibling of the node
    AST *sibling = nullptr;

    // Top level node, which stores the file name.
    std::string fileName;

    Semantic *analyzer;

    // index of the 'tables' vector 
    // for this node (if it's an id)
    SymEntry *tableEntry;

    // Variable to store information on variable types for certain declarations
    Variables theVar;

    // Expressions (arithmetic and logical) often require an operator
    Operators theOp;

    // a string, to store information for identifiers, or strings.
    std::string name;

    // Register for the node
    Registers reg;

    // an int to store information relating to the node.
    int num;

    // an int to store block information about the node
    int blockID;

    // Line number of the statement, for printing/debugging
    int lineNo;

    int conditionChild;

    int sc;

    // If it's part of an if or while
    // 1 for if, 2 for else, 3 for while
    ifWhileElseStuff isIfOrLoop;

    void printProg (int indentLvl);
    void printStmt (int indentLvl);
    void printExpr (int indentLvl);
    void printDecl (int indentLvl);

public:
    NodeType theNode;
    Stmt theStmtType;
    Expr theExprType;
    Decl theDeclType;
    Variables getTheVar(){return theVar;}

    Registers getReg(){return reg;}

    void setReg(Registers myReg){reg = myReg;}

    AST(std::string name);
    AST(int line) : lineNo(line) { 
        reg = NONE; 
        isIfOrLoop = noneOfTheBelow;
        conditionChild = 0;
    }

    ~AST()
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

    bool hasSibling() {
        return sibling != nullptr;
    }

    void setNum(int newNum){
        num = newNum;
    }

    void setBlockID(int newNum){
        blockID = newNum;
    }

    AST *getSibling() {
        return sibling;
    }

    // Helper function. often the first child is highly useful.
    AST *getFirstChild(){
        return children[0];
    }

    int getLine(){
        return lineNo;
    }

    SymEntry *getTableEntry(){
        return tableEntry;
    }

    void setTableEntry(SymEntry * entry){
        tableEntry = entry;
    }
    // Function to print
    void print(int indentLvl);

    Operators getTheOp(){
        return theOp;
    }

    void setTheVar(Variables var){
        theVar = var;
    }

    ifWhileElseStuff getIsIfOrLoop(){
        return isIfOrLoop;
    }

    void setIsIfOrLoop(ifWhileElseStuff x){
        isIfOrLoop = x;
    }

    bool checkSemantics();

    // The following functions are meant to be called after the constructor is called.
    // They set the type, and add any mandatory children
    void setAsIf(AST *ex, AST *ifBlock);
    void setAsIfElse(AST *ex, AST *ifBlock, AST *elseBlock);
    void setAsAssignment(AST *identifier, AST *assignExp);
    void setAsNull();
    void setAsReturn();
    void setAsReturn(AST *ex);
    void setAsWhile(AST *ex, AST *block);
    void setAsBreak();
    void setAsBlock(AST *node);
    void setAsFunctionStatement(AST *functionCall);
    void setAsEmptyBlock();

    // The following functions are meant to be called after the constructor is called.
    // They set the type, and add any mandatory children
    void setAsIdentifier(std::string myName);
    void setAsNumber(int myNumber);
    void setAsString(std::string *literal);
    void setAsBool(bool isTrue);
    void setAsUnary(Operators op, AST *ex);
    void setAsRelational(AST *e1, Operators op, AST *e2);
    void setAsEquality(AST *e1, Operators op, AST *e2);
    void setAsConditional(AST *e1, Operators op, AST *e2);
    void setAsArithmetic(AST *e1, Operators op, AST *e2);
    void setAsFunctionCall(AST *id);
    void setAsFunctionCall(AST *id, AST *args);
    // void setAsAssignment(AST *assignStmt);

    // The following functions are meant to be called after the constructor is called.
    // They set the type, and add any mandatory children
    void setAsDeclarator(AST *id);
    void setAsDeclarator(AST *id, AST *params);
    //void setAsFunction(AST *dec, AST *block);
    void setAsFunction(AST *block);
    void setAsMainFunction(AST *dec, AST *block);
    void setAsFunctionHeader(AST *dec, Variables varType);
    void setAsVariable(AST *id, Variables varType);
    void setAsGlobalVariable();
    void setAsParameter(Variables varType, AST *ex); // type identifier
    void setAsType(Variables varType);

    std::string getName(){
        return name;
    }

    int getNum(){
        return num;
    }

    int getBlockID(){
        return blockID;
    }

    void setConditionChild(int x){
        conditionChild = x;
    }

    int getConditionChild(){
        return conditionChild;
    }

    int getSC(){
        return sc;
    }

    void setSC(int s){
        sc = s;
    }

    std::string getMainFunction();


};



#endif
