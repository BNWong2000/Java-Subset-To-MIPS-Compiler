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
    std::string result=
    "\n_prints:\n";
    result += "\tli $s0, 0        # store 0 in $s0\n";
    result += "\tmove $s1, $a0\n";
    result += "W1:            # Loop start\n " ;
    result += "\tbeq $s0, $a1, EW1\n";
    result += "\taddu $t1, $s1, $s0\n";
    result += "\tlbu $a0, ($t1)\n";
    result += "\tli $v0, 11\n";
    result += "\tsyscall\n";
    result += "\taddiu $s0, $s0, 1\n";
    result += "\tj W1\n";
    result += "EW1:\n";
    result += "\tjr $ra";
    
    return result;
}
