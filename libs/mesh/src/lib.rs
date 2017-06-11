extern crate csv;
extern crate serde;
#[macro_use]
extern crate serde_derive;

use std::collections::BTreeSet;

#[derive(Debug, Deserialize)]
struct Point3D {
    x: f64,
    y: f64,
    z: f64,
}

#[derive(Debug)]
struct Face {
    vertices: (usize, usize, usize),
}

impl Face {
    fn new(vertices: (usize, usize, usize)) -> Face {
        Face { vertices: vertices }
    }
}

#[derive(Debug)]
struct Vertex {
    pos: Point3D,
    id: usize,
    is_keypoint: bool,
    faces: Vec<usize>, //Faces that are linked to the vertex
    adjacent_vertices: BTreeSet<usize>, //Linked vertices to vertex
}

impl Vertex {
    fn new(id: usize, pos: Point3D) -> Vertex {
        Vertex {
            id: id,
            pos: pos,
            is_keypoint: false,
            faces: Vec::new(),
            adjacent_vertices: BTreeSet::new(),
        }
    }

    fn add_face(&mut self, indx: usize) {
        self.faces.push(indx);
    }

    fn add_adjacent_ver(&mut self, indx: usize) {
        self.adjacent_vertices.insert(indx);
    }
}

#[derive(Debug)]
pub struct Mesh {
    vertices: Vec<Vertex>,
    faces: Vec<Face>,
}

impl Mesh {
    pub fn new() -> Mesh {
        Mesh {
            vertices: Vec::new(),
            faces: Vec::new(),
        }
    }

    pub fn load_vertices_from_file(&mut self, path: &str) {
        let mut rdr = csv::Reader::from_path(path).unwrap();
        
        let mut i: usize = 0;   // = 1;
        for record in rdr.deserialize() {
            let point: Point3D = record.unwrap();
            let ins_vertex = Vertex::new(i, point);
            self.vertices.push(ins_vertex);
            i += 1;
        }
    }

    pub fn load_faces_from_file(&mut self, path: &str) {
        let mut rdr = csv::Reader::from_path(path).unwrap();

        let mut i: usize = 0;   // = 1;
        for record in rdr.deserialize() {
            let mut v_indexes: (usize, usize, usize) = record.unwrap();
            v_indexes.0 -= 1;   v_indexes.1 -= 1;   v_indexes.2 -= 1;

            //Add faces to vertices
            self.vertices[v_indexes.0].add_face(i);
            self.vertices[v_indexes.1].add_face(i);
            self.vertices[v_indexes.2].add_face(i);

            //Add adjacent vertices to vertex
            self.vertices[v_indexes.0].add_adjacent_ver(v_indexes.1);
            self.vertices[v_indexes.0].add_adjacent_ver(v_indexes.2);

            self.vertices[v_indexes.1].add_adjacent_ver(v_indexes.0);
            self.vertices[v_indexes.1].add_adjacent_ver(v_indexes.2);

            self.vertices[v_indexes.2].add_adjacent_ver(v_indexes.0);
            self.vertices[v_indexes.2].add_adjacent_ver(v_indexes.1);

            //Insert initialized Face
            let ins_face = Face::new(v_indexes);
            self.faces.push(ins_face);

            i += 1;
        }
    }
}