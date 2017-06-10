function EVAL_MODEL = false_positives_negatives(V, F, IPs_alg, GT_MODEL, error_range)

model_diam = calculate_model_diameter(V);

PRO_GT = get_prominence(GT_MODEL);

rtf = size(GT_MODEL,1);
num_subjects = size(GT_MODEL,2)+1;

EVAL_MODEL = cell(rtf,num_subjects-1,5);

num_alg_points = length(IPs_alg);

for rrr=1:rtf;
    for N_min=2:num_subjects;
        
        final_GT_points = GT_MODEL{rrr,N_min-1,1};
                   
        pro_IP = PRO_GT{rrr,N_min-1};
        
        if not(isempty(final_GT_points))
            
             
            num_GT_points = length(final_GT_points);
            
            [false_negative,false_positive,WME] = FN_FP(V,F,final_GT_points,IPs_alg,model_diam, error_range,pro_IP);
               
            EVAL_MODEL{rrr,N_min-1,1}=false_negative;
            EVAL_MODEL{rrr,N_min-1,2}=false_positive;
            EVAL_MODEL{rrr,N_min-1,3}=num_GT_points;
            EVAL_MODEL{rrr,N_min-1,4}=num_alg_points;
            EVAL_MODEL{rrr,N_min-1,5}=WME;
        
        else

            EVAL_MODEL{rrr,N_min-1,1}=[];
            EVAL_MODEL{rrr,N_min-1,2}=[];
            EVAL_MODEL{rrr,N_min-1,3}=0;
            EVAL_MODEL{rrr,N_min-1,4}=num_alg_points;
            EVAL_MODEL{rrr,N_min-1,5}=[];
        
        end;
    
    end;
end;


