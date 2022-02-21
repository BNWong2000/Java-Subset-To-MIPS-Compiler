all: flex main

flex: scanner.l
	flex --c++ scanner.l

parser: parser.yy
	bison -o parser.yy



main: main.hpp lex.yy.cc main.cpp
	g++ -Wall -std=c++14 -o scanner lex.yy.cc main.cpp

clean:
	rm -rf *.yy.cc scanner
