extern crate mesh;

use mesh::Mesh;

pub struct Detector {
    mesh: Mesh,
}

impl Detector {
    pub fn new(path: &str) {
        let mut mesh = Detector {
            mesh: Mesh::new()
        };

        mesh.load_vertices_from_file("./data/MODEL_DATASET/cow_V.csv");
        mesh.load_faces_from_file("./data/MODEL_DATASET/cow_F.csv");

        mesh
    }
}