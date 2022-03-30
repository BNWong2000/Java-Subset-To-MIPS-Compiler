#ifndef REGENUMS_HPP
#define REGENUMS_HPP
#include <string>

enum Registers{
    NONE,
    t_zero,
    t_one,
    t_two,
    t_three,
    t_four,
    t_five,
    t_six,
    t_seven,
    t_eight,
    t_nine,
    s_zero,
    s_one,
    s_two,
    s_three,
    s_four,
    s_five,
    s_six,
    s_seven
};

inline std::string regToStr(Registers reg){
    switch (reg){
        case t_zero:
            return "$t0";
        case t_one:
            return "$t1";
        case t_two:
            return "$t2";
        case t_three:
            return "$t3";
        case t_four:
            return "$t4";
        case t_five:
            return "$t5";
        case t_six:
            return "$t6";
        case t_seven:
            return "$t7";
        case t_eight:
            return "$t8";
        case t_nine:
            return "$t9";
        case s_zero:
            return "$s0";
        case s_one:
            return "$s1";
        case s_two:
            return "$s2";
        case s_three:
            return "$s3";
        case s_four:
            return "$s4";
        case s_five:
            return "$s5";
        case s_six:
            return "$s6";
        case s_seven:
            return "$s7";
        default:
            ;
    }
    return "ERRORRRRR";
}

#endif