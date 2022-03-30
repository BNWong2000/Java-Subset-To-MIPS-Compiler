#include "headerFuncCode.hpp"

std::string generate_getChar(){
    std::string result = 
    "\n_getchar:\n";
    result += "\t \n";
    result += "\tsyscall \n";
    result += "\tjr $ra";
    return result;
}

std::string generate_halt(){
    std::string result = 
    "\n_halt:\n";
    result += "\tli $v0, 10 \n";
    result += "\tsyscall \n";
    result += "\tjr $ra";
    return result;
}

std::string generate_printb(){
    std::string result = 
    "\n_printb:\n";
    result += "\tli $v0, 10 \n";
    result += "\tsyscall \n";
    result += "\tjr $ra";
    return result;
}

std::string generate_printc(){
    std::string result = 
    "\n_printc:\n";
    result += "\tli $v0, 11 \n";
    result += "\tsyscall \n";
    result += "\tjr $ra";
    return result;
}

std::string generate_printi(){
    std::string result = 
    "\n_printi:\n";
    result += "\tli $v0, 1 \n";
    result += "\tsyscall \n";
    result += "\tjr $ra";
    return result;
}

std::string generate_prints(){
    std::string result;
    return result;
}
