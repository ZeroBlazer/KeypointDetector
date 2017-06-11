#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/freeglut.h>
#include <iostream>
#include "../../detector_cpp/mesh.h"

using namespace std;

enum Rotation {
    None,
    Rotation_X,
    Rotation_mX,
    Rotation_Y,
    Rotation_mY
};

Rotation rot = None;
static GLfloat  spin_step = 0.0001,
                spin_x = 0.0,
                spin_y = 0.0;
size_t  selection_m = 0,
        selection_n = 0;
float   _dx = 0.25,
        _dy = 0.25,
        _dz = 0.25;

GLfloat ctrlpoints[4][4][3] = {
    {{-1.5, -1.5, 4.0}, {-0.5, -1.5, 2.0}, 
	{0.5, -1.5, -1.0}, {1.5, -1.5, 2.0}}, 
    {{-1.5, -0.5, 1.0}, {-0.5, -0.5, 3.0}, 
	{0.5, -0.5, 0.0}, {1.5, -0.5, -1.0}}, 
    {{-1.5, 0.5, 4.0}, {-0.5, 0.5, 0.0}, 
	{0.5, 0.5, 3.0}, {1.5, 0.5, 4.0}}, 
    {{-1.5, 1.5, -2.0}, {-0.5, 1.5, -2.0}, 
	{0.5, 1.5, 0.0}, {1.5, 1.5, -1.0}}
};

void initlights(void)
{
    GLfloat ambient[] = { 0.2, 0.2, 0.2, 1.0 };
    GLfloat position[] = { 0.0, 0.0, 2.0, 1.0 };
    GLfloat mat_diffuse[] = { 0.6, 0.6, 0.6, 1.0 };
    GLfloat mat_specular[] = { 1.0, 1.0, 1.0, 1.0 };
    GLfloat mat_shininess[] = { 50.0 };
    
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);

    glLightfv(GL_LIGHT0, GL_AMBIENT, ambient);
    glLightfv(GL_LIGHT0, GL_POSITION, position);
    
    glMaterialfv(GL_FRONT, GL_DIFFUSE, mat_diffuse);
    glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
    glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);
}

void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glPushMatrix();
    glRotatef(85.0, 1.0, 1.0, 1.0);
    
    glDisable(GL_LIGHTING);
    // Mostramos los puntos de control
    glBegin(GL_POINTS);
    for (int j = 0; j < 4; j++) {
        for (int i = 0; i < 4; i++) {
            glColor3f(1.0 - j/255.0, 1.0, i/255.0);
            glVertex3fv(&ctrlpoints[j][i][0]);
        }
    }
    glEnd();

    //SURFACE
    glEnable(GL_LIGHTING);
    glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4,
	    0, 1, 12, 4, &ctrlpoints[0][0][0]);

    glEvalMesh2(GL_FILL, 0, 20, 0, 20);
    glPopMatrix();
    glFlush();
    if(rot == Rotation_X)
        glRotatef(spin_x, 1.0, 0.0, 0.0);
    if(rot == Rotation_Y)
        glRotatef(spin_y, 0.0, 1.0, 0.0);
}

void spinDisplay(void)
{
    if(rot == Rotation_X) {
        spin_x = spin_x + spin_step;
        if (spin_x > 360.0)
            spin_x = spin_x - 360.0;
    }

    if(rot == Rotation_Y) {
        spin_y = spin_y + spin_step;
        if (spin_y > 360.0)
            spin_y = spin_y - 360.0;
    }

    if(rot == Rotation_mX) {
        spin_x = spin_x - spin_step;
        if (spin_x < 0.0)
            spin_x = spin_x + 360.0;
    }

    if(rot == Rotation_mY) {
        spin_y = spin_y - spin_step;
        if (spin_y < 0.0)
            spin_y = spin_y + 360.0;
    }
    
    glutPostRedisplay();
}

void processSelection(int x, int y) {
    unsigned char res[3];
    GLint viewport[4]; 
    // renderSelection();
    glGetIntegerv(GL_VIEWPORT, viewport);
    glReadPixels(x, viewport[3] - y, 1,1,GL_RGB, GL_UNSIGNED_BYTE, &res);

    selection_m = 255 - (int)res[0]; //En el canal Rojo
    selection_n = (int)res[2];       //En el canal Azul

    cout << "Selected node: [" << selection_m << ", " << selection_n << "]" << endl;
}

void updateCoordinates(float dx = 0.0, float dy = 0.0, float dz = 0.0) {
    ctrlpoints[selection_m][selection_n][0] += dx;
    ctrlpoints[selection_m][selection_n][1] += dy;
    ctrlpoints[selection_m][selection_n][2] += dz;
}

void myinit(void)
{
    glClearColor (0.0, 0.0, 0.0, 1.0);
    glEnable (GL_DEPTH_TEST);
    glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 4,
	    0, 1, 12, 4, &ctrlpoints[0][0][0]);
    glEnable(GL_MAP2_VERTEX_3);
    glEnable(GL_AUTO_NORMAL);
    glEnable(GL_NORMALIZE);
    glMapGrid2f(20, 0.0, 1.0, 20, 0.0, 1.0);
    initlights();	/* for lighted version only */
    glPointSize(6.0);
}

void myReshape(int w, int h)
{
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if (w <= h)
	    glOrtho(-4.0, 4.0, -4.0 * (GLfloat)h / (GLfloat)w, 4.0 * (GLfloat)h / (GLfloat)w, -4.0, 4.0);
    else
	    glOrtho(-4.0 * (GLfloat)w / (GLfloat)h, 4.0 * (GLfloat)w / (GLfloat)h, -4.0, 4.0, -4.0, 4.0);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void keyboard(unsigned char key, int x, int y) {
    switch(key) 
    {
        //CAMERA MOVEMENT
        case 'w':
        case 'W':
            rot = Rotation_X;
            glutIdleFunc(spinDisplay);
            break;
        case 's':
        case 'S':
            rot = Rotation_mX;
            glutIdleFunc(spinDisplay);
            break;
        case 'a':
        case 'A':
            rot = Rotation_Y;
            glutIdleFunc(spinDisplay);
            break;
        case 'd':
        case 'D':
            rot = Rotation_mY;
            glutIdleFunc(spinDisplay);
            break;
        // //ZOOMING CONTROL
        // case 'q':
        // case 'Q':
        //     break;
        // case 'e':
        // case 'E':
        //     break;
        //CHANGE CONTROL X
        case 'u':
        case 'U':
            updateCoordinates(_dx);
            break;
        case 'j':
        case 'J':
            updateCoordinates(-1*_dx);
            break;
        //CHANGE CONTROL Y
        case 'i':
        case 'I':
            updateCoordinates(0.0, _dy);
            break;
        case 'k':
        case 'K':
            updateCoordinates(0.0, -1*_dy);
            break;
        //CHANGE CONTROL Z
        case 'o':
        case 'O':
            updateCoordinates(0.0, 0.0, _dz);
            break;
        case 'l':
        case 'L':
            updateCoordinates(0.0, 0.0, -1*_dz);
            break;
        //EXIT CONTROL
        case 27: // escape
            exit(0);
            break;
    }
    glutPostRedisplay();
}

void keyboard_up(unsigned char key, int x, int y) {
    switch(key) 
    {
        //CAMERA MOVEMENT
        case 'w':
        case 'W':
            rot = None;
            glutIdleFunc(NULL);
            break;
        case 's':
        case 'S':
            rot = None;
            glutIdleFunc(NULL);
            break;
        case 'a':
        case 'A':
            rot = None;
            glutIdleFunc(NULL);
            break;
        case 'd':
        case 'D':
            rot = None;
            glutIdleFunc(NULL);
            break;
        //ZOOMING CONTROL
        // case 'q':
        // case 'Q':
        //     break;
        // case 'e':
        // case 'E':
        //     break;
    }
}

void mouse(int button, int state, int x, int y) 
{
    switch (button) {
        case GLUT_LEFT_BUTTON:
            if (state == GLUT_DOWN)
                processSelection(x,y);
            break;
        case GLUT_RIGHT_BUTTON:
            break;
        case GLUT_MIDDLE_BUTTON:
            // if (state == GLUT_DOWN)
                // glutIdleFunc(spinDisplay);
            break;
      default:
         break;
   }
   glutPostRedisplay();
}

int main(int argc, char** argv)
{
    Mesh mesh;
    glutInit(&argc, argv);
    glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);
    //glutInitPosition (0, 0, 500, 500);
    glutCreateWindow (argv[0]);
    // glutInitWindowSize (640, 480);
    myinit();
    glutReshapeFunc(myReshape);
    glutDisplayFunc(display);
    glutKeyboardFunc(keyboard);
    glutKeyboardUpFunc(keyboard_up);
    glutMouseFunc(mouse);
    glutMainLoop();
}