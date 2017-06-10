extern crate mesh;

use mesh::Mesh;

fn main() {
    let mut mesh = Mesh::new();
    mesh.load_vertices_from_file("./data/model_dataset/cow_V.csv");
    mesh.load_faces_from_file("./data/model_dataset/cow_F.csv");

    println!("Hello, world!");
}
