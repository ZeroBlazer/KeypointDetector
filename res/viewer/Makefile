CC = g++
CFLAGS = -Wall -std=c++11 
LIBS = -lGL -lGLU -lglut -L/usr/lib64 -lstdc++ -I/usr/local/include -L/usr/local/lib

EXECS = viewer
OBJS = main.o mesh.o
MSH_PATH = ../../detector_cpp/

all: ${EXECS}

run: all
	./viewer

viewer: ${OBJS}
	${CC} ${CFLAGS} -o viewer ${OBJS} ${LIBS} /usr/local/lib/libmatio.so

main.o: main.cpp
	${CC} ${CFLAGS} -c main.cpp ${LIBS}

mesh.o: ${MSH_PATH}mesh.cpp ${MSH_PATH}mesh.h
	${CC} ${CFLAGS} -c ${MSH_PATH}mesh.cpp ${LIBS}

clean:
	rm -f ${EXECS} ${OBJS}
	@echo "all cleaned up!"