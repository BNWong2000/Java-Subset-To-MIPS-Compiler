%defines

%code{
    


}

%code requires{
    #include <string>
}

%union{
    int ival;
    std::string *str;
}

%token    <str>  T_ID
%token    <ival> T_NUM
%token    T_ADD
%token    T_SUB
%token    T_DIV
%token    T_MULT
%token    T_MOD
%token    T_LT
%token    T_GT
%token    T_GE
%token    T_LE
%token    T_EQ
%token    T_BEQ
%token    T_NEQ
%token    T_NOT
%token    T_AND
%token    T_OR
%token    T_IF
%token    T_ELSE
%token    T_WHILE
%token    T_FOR
%token    T_BREAK
%token    T_RET
%token    T_STR
%token    T_LB
%token    T_RB
%token    T_RCB
%token    T_LCB
%token    T_SC
%token    T_COM
%token    T_TRUE
%token    T_FALSE
%token    T_BOOL
%token    T_INT
%token    T_VOID
%token    T_WARN
%token    T_ERR

%start S

%%

%%
