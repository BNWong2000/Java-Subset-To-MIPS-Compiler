#include <iostream>
#include <string>

#include "ast.hpp"

Arithmetic::Arithmetic(Operators myOp, Expression e1, Expression e2){
    op = myOp;
}

Comparison::Comparison(Operators myOp, Expression e1, Expression e2){
    op = myOp;
}


