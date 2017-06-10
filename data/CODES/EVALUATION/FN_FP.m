function [false_negative,false_positive,WME] = FN_FP(V,F,final_GT_points,IPs_alg,model_diam, error_range, pro_IP)

false_negative = zeros(length(error_range),1);
false_positive = zeros(length(error_range),1);
WME = zeros(length(error_range),1);

num_GT_points = length(final_GT_points);
num_alg_points = length(IPs_alg);
    
[D,S,Q] = perform_fast_marching_mesh(V', F', final_GT_points);
        
distance_alg_points = D(IPs_alg);
corres_alg_points = Q(IPs_alg);

[D_a,S_a,Q_a] = perform_fast_marching_mesh(V', F', IPs_alg);
        
distance_GT_points = D_a(final_GT_points);
corres_GT_points = Q_a(final_GT_points);

sum_pro_IP = sum(pro_IP);

for e=1:length(error_range);

    err_tol = error_range(e)*model_diam;
    
    correctly_detected_count = 0;
    not_false_alarm_count = 0;
        
    GT_matched=[];
    
    for p = 1:num_GT_points;
        
        GT_point = final_GT_points(p);
        corr_alg_to_GT = find(corres_alg_points == GT_point);
        vic_GT = find(distance_alg_points(corr_alg_to_GT) <= err_tol); 
        
        if not(isempty(vic_GT));
            correctly_detected_count = correctly_detected_count + 1;
            GT_matched=[GT_matched;p];
        end;
       
    end;
    
    for p = 1:num_alg_points;
        
        alg_point = IPs_alg(p);
        corr_GT_to_alg = find(corres_GT_points == alg_point);
        vic_alg = find(distance_GT_points(corr_GT_to_alg) <= err_tol); 

        if not(isempty(vic_alg));
            not_false_alarm_count = not_false_alarm_count + 1;
        end;
    
    end;
    
    sum_GT_matched = sum(pro_IP(GT_matched));
    WME(e) = 1 - sum_GT_matched/sum_pro_IP;
    
    false_negative(e) = num_GT_points - correctly_detected_count;
    false_positive(e) = num_alg_points - not_false_alarm_count;
    
end;