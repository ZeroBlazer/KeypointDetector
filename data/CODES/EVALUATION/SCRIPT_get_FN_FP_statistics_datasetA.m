
 method_name = 'Mesh_saliency';
% method_name = 'Salient_points';
% method_name = '3D-Harris';
% method_name = '3D-SIFT';
% method_name = 'SD-corners';
% method_name = 'HKS';

n = 11;
sigma = 0.05;

% Locate directory of error rates of models
FN_FP_MAIN_FOLDER = 'C:\IP_BENCHMARK\OUTPUT_DATA\FN_FP_DATA_A\';
method_name = 'Mesh_saliency';
FN_FP_DIR = [FN_FP_MAIN_FOLDER  method_name '\']; 
 
radius_tol_factor = [0.01:0.01:0.1];
error_range = [0:0.005:0.12];

load exp_model_list_A;
exp_model_list = exp_model_list_A;

num_models = length(exp_model_list);

% get the size of EVAL_MODEL
model_name=exp_model_list{1};
load([FN_FP_DIR model_name]);
rtf = size(EVAL_MODEL,1);
num_subjects = size(EVAL_MODEL,2)+1;
FN_range = length(EVAL_MODEL{1,1,1});


if not(length(radius_tol_factor)== rtf)
    error('Size of the EVAL_MODEL is not in accordance with the tolerance factor vector');
end;

if not(length(error_range) == FN_range);
    error('Range of FN is not in accordance with the error range vector');
end;

FN_all_models = zeros(FN_range,num_models);
FP_all_models = zeros(FN_range,num_models);
WME_all_models = zeros(FN_range,num_models);

[dummy r_index] = min(abs(radius_tol_factor - sigma));
N_index = n - 1;

count = num_models;

for exp_model = 1:num_models;
    
    model_name=exp_model_list{exp_model};
    load([FN_FP_DIR model_name]);
    
    E_MODEL = EVAL_MODEL(r_index,N_index,:);
    E_MODEL = E_MODEL(:);
        
    num_GT_points = E_MODEL{3};
    num_alg_points = E_MODEL{4};
    
    if num_GT_points == 0;
        count = count-1;
    else
        FN = E_MODEL{1}/num_GT_points;
        FP = E_MODEL{2}/num_alg_points;
        
        FN_all_models(:,exp_model)=FN(:);
        FP_all_models(:,exp_model)=FP(:);
        WME_all_models(:,exp_model)=E_MODEL{5};
    end;
    
end;
    
FN_average = sum(FN_all_models,2)/count;
FP_average = sum(FP_all_models,2)/count;
WME_average = sum(WME_all_models,2)/count;    

%%%%% PLOTTING %%%%%%%%%%%%%%%%

marker_size = 8;
line_width = 1;
marker_shape = '-ko';

figure(1);
plot(error_range,FN_average,marker_shape,'LineWidth',line_width,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',marker_size);   
xlabel('{\itr} ' );
ylabel('Average {\itFNE}');

figure(2);
plot(error_range,FP_average,marker_shape,'LineWidth',line_width,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',marker_size);   
xlabel('{\itr} ' );
ylabel('Average {\itFPE}');

figure(3);
plot(error_range,WME_average,marker_shape,'LineWidth',line_width,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',marker_size);   
xlabel('{\itr} ' );
ylabel('Average {\itWME}');     
    