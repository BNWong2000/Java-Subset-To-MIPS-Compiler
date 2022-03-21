#include "symbolTable.hpp"

std::string SymEntry::getSig(){
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