all: flex main

flex: scanner.l
	flex --c++ scanner.l


main: main.hpp lex.yy.cc main.cpp
	g++ -Wall -std=c++14 -o scanner lex.yy.cc main.cpp

clean:
	rm -rf *.yy.cc scanner
