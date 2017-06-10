#-------------------------------------------------
#
# Project created by QtCreator 2014-05-01T14:24:33
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = detector
TEMPLATE = app


SOURCES +=  main.cpp\
            detector.cpp \
            pclviewer.cpp \
            mesh.cpp

HEADERS  += pclviewer.h \
            detector.h \
            mesh.h

FORMS += pclviewer.ui
