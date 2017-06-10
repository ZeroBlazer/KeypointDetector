CC = g++
CFLAGS = -Wall -std=c++11 
LIBS = -lGL -lGLU -lglut -L/usr/lib64 -lstdc++

EXECS = viewer
OBJS = main.o 

all: ${EXECS}

run: all
	./viewer

viewer: ${OBJS}
	${CC} ${CFLAGS} -o viewer ${OBJS} ${LIBS}

main.o: main.cpp
	${CC} ${CFLAGS} -c main.cpp ${LIBS}

clean:
	rm -f ${EXECS} ${OBJS}
	@echo "all cleaned up!"