%defines

%code{
    


}

%union{
    int ival;
}

%token <ival> T_NUM
    T_ID = 1,
    T_NUM,
    T_ADD,
    T_SUB,
    T_DIV,
    T_MULT,
    T_MOD,
    T_LT,
    T_GT,
    T_GE,
    T_LE,
    T_EQ,
    T_BEQ,
    T_NEQ,
    T_NOT,
    T_AND,
    T_OR,
    T_IF,
    T_ELSE,
    T_WHILE,
    T_FOR,
    T_BREAK,
    T_RET,
    T_STR,
    T_LB,
    T_RB,
    T_RCB,
    T_LCB,
    T_SC,
    T_COM,
    T_TRUE,
    T_FALSE,
    T_BOOL,
    T_INT,
    T_VOID,
    T_WARN,
    T_ERR

%start S

%%

%%
