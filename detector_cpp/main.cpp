#include "detector.h"
#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
    if(argc != 3) {
        cout << "Uso: <ext> <filename>" << endl;
        return 0;
    }
    
    Mesh mesh;
    if(strcmp(argv[1], "off") == 0) {
        mesh.loadOffFile(argv[2]);
    } else if (strcmp(argv[1], "mat") == 0) {
        mesh.loadMatFile(argv[2]);
    } else {
        cout << "Not a valid file" << endl;
        return 0;
    }
    
    Detector KPD(&mesh);
    vector<Vertex> interestPoints;
    KPD.interestPoints(interestPoints, 7);

    return 0;
}
