#pragma once

#ifndef SYMENTRY_HPP
#define SYMENTRY_HPP

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

    std::string getSig(){
        std::string result = "";
        if(isFunc){
            result += "f(";
            if(params.size() > 0){
                result += varToString(params[0]);
                for(int i = 1; i < params.size(); i++){
                    result += ", " + varToString(params[i]);
                }
            }
            result += ")";
        }else{
            return varToString(type);
        }
        return result;

    }

};

#endif