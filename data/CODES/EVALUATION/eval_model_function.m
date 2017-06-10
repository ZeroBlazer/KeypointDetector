
function EVAL_MODEL = eval_model_function(model_name, method_name)

global MODEL_DIR
global GROUND_TRUTH_DIR 
global ALGORITHM_IPs_MAIN_FOLDER
global FN_FP_MAIN_FOLDER

load([MODEL_DIR model_name]);
load([GROUND_TRUTH_DIR model_name]);

global error_range

%%%%% DEFINE METHOD / INPUT OUTPUT FOLDERS acc. to method

ALGORITHM_IPs_DIR = [ALGORITHM_IPs_MAIN_FOLDER method_name '\'];
FN_FP_DIR = [FN_FP_MAIN_FOLDER  method_name '\'];

%%%%%%%%%%%%%

load([ALGORITHM_IPs_DIR model_name]);
IPs_alg = IP_vertex_indices;

EVAL_MODEL = false_positives_negatives(V, F, IPs_alg, GT_MODEL, error_range);

save([FN_FP_DIR model_name],'EVAL_MODEL');
