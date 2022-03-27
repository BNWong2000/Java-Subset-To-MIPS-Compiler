#pragma once

#ifndef SYMBOLTABLE_HPP
#define SYMBOLTABLE_HPP

#include <unordered_map>
#include <vector>
#include <string>
#include <variant>
#include "ast.hpp"


class SymEntry {
public:
    Variables type;
    std::vector<Variables> params;
    bool isFunc;
    bool isGlobal;
    int offset;
    SymEntry(){offset = -1;}
    SymEntry(Variables var){
        type = var;
        offset = -1;
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