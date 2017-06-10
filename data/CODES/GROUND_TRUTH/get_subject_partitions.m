
function [GD_D, GD_S, GD_Q, V_IP] = get_subject_partitions(subject_name, model_name, V, F)

global SUBJECT_DATA_DIR

load([SUBJECT_DATA_DIR subject_name '-' model_name '_points.txt']);
str=['I_points=' subject_name '_' model_name '_points;'];
eval(str);

V_IP = map_user_IP_to_vertices(I_points,V);
        
[D,S,Q] = perform_fast_marching_mesh(V', F', V_IP);
  
GD_D = D;
GD_S = S;
GD_Q = Q;
