
function GT_MODEL = ground_truth_function(model_name)

global MODEL_DIR 
global SUBJECT_IP_PARTITIONS_DIR 

global subject_list

load([MODEL_DIR model_name]);

%%%% subject list %%%%%%%%%%%%

num_subjects=length(subject_list);

%%%% read IPs from raw data obtained from user interface %%%%%%%% 
%%%% geodesic partitions (and distances) of subjects' IP points of the model %%%%%%%%
%%%%% INPUT FILES : in SUBJECT_DATA_DIR
%%%%% OUTPUT FILES : to SUBJECT_IP_PARTITIONS_DIR

all_marked_IP = [];

for subj = 1:num_subjects;
    
    subject_name = subject_list{subj};
    % disp([model_name '(' num2str(exp_model) '/' num2str(num_models) ')' '  subject:  ' subject_name '(' num2str(subj) '/' num2str(num_subjects) ')']);
    [GD_D, GD_S, GD_Q, V_IP] = get_subject_partitions(subject_name, model_name, V, F);
    
    all_marked_IP = union(all_marked_IP,V_IP);
    
    save([SUBJECT_IP_PARTITIONS_DIR model_name '_' subject_name], 'GD_D', 'GD_S', 'GD_Q', 'V_IP');
    
end;


num_marked = length(all_marked_IP);

D_marked_IP = zeros(num_marked,num_marked);

for i=1:num_marked;
    p_point=all_marked_IP(i);
    end_points = all_marked_IP;
    options.nb_iter_max = Inf;
    [D,S,Q] = perform_fast_marching_mesh(V', F', p_point, options);
    d = D(end_points);
    D_marked_IP(:,i)=d;
end;

%%%% Construct ground truth
%%%% INPUT FILES : in SUBJECT_IP_PARTITIONS_DIR 

model_diam = calculate_model_diameter(V);

disp('First pass to construct Ground Truth: Formation of clustered subject points');
GT_MODEL = construct_ground_truth(model_name, model_diam, all_marked_IP, D_marked_IP);

disp('Second pass to construct Ground Truth: Elimination of close clusters');
new_GT_MODEL = refine_final_GT_points(GT_MODEL, model_diam, all_marked_IP, D_marked_IP);
GT_MODEL = new_GT_MODEL;




