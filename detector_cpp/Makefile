CC = g++
CFLAGS = -Wall
LIBS = -L/usr/lib64 -lstdc++ -lgsl -lgslcblas -lm -lmatio #-fopenmp

EXECS = kp-detector
OBJS = main.o detector.o mesh.o
FO = ../data/off_files/model.off
FM = ../data/model_dataset/ant.mat

all: ${EXECS}

run: all
	./detector off ${FO}

run-mat: all
	./detector mat ${FM}

kp-detector: ${OBJS}
	${CC} ${CFLAGS} -o detector ${OBJS} ${LIBS}

main.o: main.cpp
	${CC} ${CFLAGS} -c main.cpp ${LIBS}

detector.o: detector.cpp detector.h mesh.o
	${CC} ${CFLAGS} -c detector.cpp ${LIBS}

mesh.o: mesh.cpp mesh.h
	${CC} ${CFLAGS} -c mesh.cpp ${LIBS}

clean:
	rm -f ${EXECS} ${OBJS}
	@echo "all cleaned up!"