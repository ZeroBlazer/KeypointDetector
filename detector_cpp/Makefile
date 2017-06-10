CC = g++
CFLAGS = -Wall #/usr/include/gsl# -std=c++11 
#LIBS = -lGL -lGLU -lglut -L/usr/lib64 -lstdc++ -lgsl -lgslcblas -lm -lmatio
LIBS = -L/usr/lib64 -lstdc++ -lgsl -lgslcblas -lm -lmatio

OBJS = main.o harrisdetector.o mesh.o

all: detector

detector: ${OBJS}
	${CC} ${CFLAGS} -o detector ${OBJS} ${LIBS}

main.o: main.cpp
	${CC} ${CFLAGS} -c main.cpp ${LIBS}

harrisdetector.o: harrisdetector.cpp harrisdetector.h mesh.o
	${CC} ${CFLAGS} -c harrisdetector.cpp

mesh.o: mesh.cpp mesh.h
	${CC} ${CFLAGS} -c mesh.cpp

run:
	./detector 

clean:
	rm -f detector ${OBJS}
	@echo "all cleaned up!"