
 method_name = 'Mesh_saliency';
% method_name = 'Salient_points';
% method_name = '3D-Harris';
% method_name = '3D-SIFT';
% method_name = 'SD-corners';
% method_name = 'HKS';

path(path,'C:\toolbox_peyre\toolbox_graph\');
path(path,'C:\toolbox_peyre\toolbox_fast_marching\');
path(path,'C:\toolbox_peyre\toolbox_fast_marching\toolbox\');

global MODEL_DIR                    % MODEL_DIR : Directory where the 3D models are present in MAT files.
global GROUND_TRUTH_DIR             % GROUND_TRUTH_DIR : Directory where final ground truth data is stored.
global ALGORITHM_IPs_MAIN_FOLDER    % ALGORITHM_IPs_MAIN_FOLDER : Directory where subfolders of individaul algorithms are present.
                                    % The subfolders contain interest points detected by the corresponding algorithm. 
                                    
global FN_FP_MAIN_FOLDER       % FN_FP_MAIN_FOLDER: Directory where error rates of algorithms are stored.

% Locate input directories
MODEL_DIR='C:\IP_BENCHMARK\MODEL_DATASET\';
GROUND_TRUTH_DIR = 'C:\IP_BENCHMARK\OUTPUT_DATA\GROUND_TRUTH_B\';
ALGORITHM_IPs_MAIN_FOLDER = 'C:\IP_BENCHMARK\ALGORITHMs_INTEREST_POINTS\';

% Locate output directory
FN_FP_MAIN_FOLDER = 'C:\IP_BENCHMARK\OUTPUT_DATA\FN_FP_DATA_B\';

global error_range
error_range = [0:0.005:0.12];

load exp_model_list_B;
exp_model_list = exp_model_list_B;
num_models = length(exp_model_list);

for exp_model = 1:num_models;
    
    model_name=exp_model_list{exp_model};
    disp(exp_model); disp(model_name);
    EVAL_MODEL = eval_model_function(model_name, method_name);
    
end;
