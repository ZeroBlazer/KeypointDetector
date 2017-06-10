
function new_GT_MODEL = refine_final_GT_points(GT_MODEL, model_diam, all_marked_IP, D_marked_IP)

global radius_tolerance_factor

new_GT_MODEL = GT_MODEL;
num_subjects = size(GT_MODEL,2)+1;
rtf = length(radius_tolerance_factor);

for rrr=1:rtf;
  
    radius_tol = radius_tolerance_factor(rrr)*model_diam;

    for N_min=2:num_subjects;
        
        GT_points = GT_MODEL{rrr,N_min-1,1};
        c_sets = GT_MODEL{rrr,N_min-1,2};
             
        if not(isempty(GT_points));
            
            num_GT_points = length(GT_points);
            
            mark_redundant = [];
            
            Ind_s = zeros(num_GT_points,1);
            for p=1:num_GT_points;
                p_point = GT_points(p);
                Ind_s(p) = find(all_marked_IP==p_point);
            end;
            
            for p=1:num_GT_points;
                
                d=D_marked_IP(Ind_s,Ind_s(p));
                set_p = str2num(c_sets{p});
                
                for q=p+1:num_GT_points;
                  
                    if ( d(q) <= 2*radius_tol )
                        set_q = str2num(c_sets{q});
                        if length(set_p) >= length(set_q);
                            mark_redundant = [mark_redundant q];
                        end;
                    end;
                    
                end;
            
            end;
            
            remained_points = setdiff([1:num_GT_points],mark_redundant);
            
            final_GT_points = GT_points(remained_points);
            new_clustered_sets = c_sets(remained_points);
                      
            new_GT_MODEL{rrr,N_min-1,1} = final_GT_points;
            new_GT_MODEL{rrr,N_min-1,2} = new_clustered_sets;
            
        end;

    end;
    
end;
            
            
            
            
            
            
            