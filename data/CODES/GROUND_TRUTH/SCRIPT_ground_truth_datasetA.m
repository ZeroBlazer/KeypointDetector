

path(path,'C:\toolbox_peyre\toolbox_graph\');
path(path,'C:\toolbox_peyre\toolbox_fast_marching\');
path(path,'C:\toolbox_peyre\toolbox_fast_marching\toolbox\');

global MODEL_DIR                    % MODEL_DIR : Directory where the 3D models are present in MAT files.
global SUBJECT_DATA_DIR             % SUBJECT_DATA_DIR : Directory where interest points marked by human subject's are stored.
global SUBJECT_IP_PARTITIONS_DIR    % SUBJECT_IP_PARTITIONS_DIR : Intermediate mat files storing a model partitioned into geodesic neighborhoods around a subject's interest points
global GROUND_TRUTH_DIR             % GROUND_TRUTH_DIR : Directory where final ground truth data is stored.

% Locate input directories where data will be read from 
MODEL_DIR='C:\IP_BENCHMARK\MODEL_DATASET\';
SUBJECT_DATA_DIR = 'C:\IP_BENCHMARK\HUMAN_SUBJECTs_INTEREST_POINTS\';

% Locate output directories where data will be written to
SUBJECT_IP_PARTITIONS_DIR = 'C:\IP_BENCHMARK\OUTPUT_DATA\SUBJECT_IP_PARTITIONS_A\';
GROUND_TRUTH_DIR = 'C:\IP_BENCHMARK\OUTPUT_DATA\GROUND_TRUTH_A\';

global radius_tolerance_factor
radius_tolerance_factor = [0.01:0.01:0.1];

global subject_list;
load subject_list_A;
subject_list = subject_list_A;

load exp_model_list_A;
exp_model_list = exp_model_list_A;
num_models = length(exp_model_list);


for exp_model = 1:num_models;
    
    model_name=exp_model_list{exp_model};
    disp(exp_model); disp(model_name);
    GT_MODEL = ground_truth_function(model_name);
    
    save([GROUND_TRUTH_DIR model_name],'GT_MODEL');
    
end;

