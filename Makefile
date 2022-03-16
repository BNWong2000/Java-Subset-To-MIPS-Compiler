CC := clang++
CXXFLAGS := -std=c++14 -Wall
objs := parser.o scanner.o main.o driver.o ast.o semantic.o


all: main

%.cc %.hh: %.yy
	bison -o $*.cc $<

%.cc: %.l
	flex --c++ -o $@ $<


-include $(OBJ:.o=.d)

%.o: %.cc
	$(CC) $(CXXFLAGS) -c $< -MMD -MF $*.d

%.o: %.cpp
	$(CC) $(CXXFLAGS) -c $< -MMD -MF $*.d

tools: parser.yy scanner.l
	bison -o parser.cc parser.yy
	flex --c++ -o scanner.cc scanner.l

main: $(objs)
	$(CC) $(CXXFLAGS) -o $@ $^

clean:
	rm -rf *.o *.hh *.cc parser *.d
