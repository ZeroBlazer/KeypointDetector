
function model_diameter = calculate_model_diameter(V)

num_vertices=length(V);
D=zeros(num_vertices,1);

for v=1:num_vertices;
    
    c_vertex = V(v,:);
    d =  sqrt( sum( ( V - repmat(c_vertex,num_vertices,1) ).^2 , 2) );
    D(v) = max(d(:));

end;

model_diameter = max(D);



    
    