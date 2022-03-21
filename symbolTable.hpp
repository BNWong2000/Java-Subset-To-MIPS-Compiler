#pragma once

#ifndef SYMBOLTABLE_HPP
#define SYMBOLTABLE_HPP

#include <unordered_map>
#include <vector>
#include <string>
#include "ast.hpp"


class SymEntry {
public:
    Variables type;
    std::vector<Variables> params;
    bool isFunc;

    SymEntry(){}
    SymEntry(Variables var){
        type = var;
    }

    void addParam(Variables var){
        params.push_back(var);
    }

    std::string getSig();

    std::string getRV(){
        return varToString(type);
    }

};

class SymbolTable{
private:
    std::vector <std::unordered_map<std::string, SymEntry *>> tables;

public:
    std::unordered_map<std::string, SymEntry *> &operator[](int index){
        return tables[index];
    }

    void push_back(std::unordered_map<std::string, SymEntry *> entry){
        tables.push_back(entry);
    }

    int size(){
        return tables.size();
    }

    // SymbolTable();
    // ~SymbolTable() = default;
};




#endif