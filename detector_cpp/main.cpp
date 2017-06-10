#include "harrisdetector.h"
#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
    if(argc < 2) {
        cout << "Ingresar nombre de archivo" << endl;
        return 0;
    }
    Mesh mesh;
//    mesh.loadOffFile(argv[1]);
    mesh.loadMatFile(argv[1]);
    HarrisDetector HD(&mesh);
    vector<Vertex> interestPoints;
    HD.interestPoints(interestPoints, 7);

    return 0;
}
