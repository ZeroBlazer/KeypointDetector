#include "detector.h"
#include <iostream>
#include <stdio.h>

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
    // double start = omp_get_wtime();
    KPD.interestPoints(interestPoints, 7);
    // double end = omp_get_wtime();
    // printf("start = %.16g\nend = %.16g\ndiff = %.16g\n", start, end, end - start); 

    return 0;
}

// 3D Keypoints Points were successfully detected :)

// real    0m11.773s
// user    0m11.672s
// sys     0m0.094s

// 3D Keypoints Points were successfully detected :)
// start = 1794.723143
// end = 1812.07836
// diff = 17.35521700000004

// real    0m17.943s
// user    1m8.188s
// sys     0m0.219s