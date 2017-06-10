
function GT_MODEL = construct_ground_truth(model_name, model_diam, all_marked_IP, D_marked_IP)

global SUBJECT_IP_PARTITIONS_DIR

global radius_tolerance_factor
global subject_list

rtf = length(radius_tolerance_factor);

num_subjects = length(subject_list);

GT_MODEL = cell(rtf,num_subjects-1,2);

for rrr=1:rtf;
    
    radius_tol = radius_tolerance_factor(rrr)*model_diam;
    
    count=0;
    
    all_subject_IP_points = cell(num_subjects,1);
    
    clustered_sets={};
    
    for subj=1:num_subjects;
        subject_name=subject_list{subj};
        load([SUBJECT_IP_PARTITIONS_DIR model_name '_' subject_name]);
        all_subject_IP_points{subj}=V_IP;
    end;
    
    for subj=1:num_subjects;
        
        subject_name=subject_list{subj};
        load([SUBJECT_IP_PARTITIONS_DIR model_name '_' subject_name]);
        
        num_points = length(V_IP);
 
        for p=1:num_points;
            
            IP_p = V_IP(p);
            
            D_p_vic = (GD_Q == IP_p).*GD_D + not(GD_Q == IP_p)*2*max(GD_D(:));
            P_vic = D_p_vic < radius_tol;
                        
            other_points_vic = [];
            
            for uu=1:num_subjects;
                if not(uu==subj);
                    V_other_IP=all_subject_IP_points{uu};
                    num_other_points = length(V_other_IP);
                    for pp=1:num_other_points;
                        IP_pp = V_other_IP(pp);
                        if P_vic(IP_pp);
                            other_points_vic=[other_points_vic IP_pp];
                        end;
                    end;
                end;
            end;
            
            if not(isempty(other_points_vic));
                count = count+1;
                clustered_sets{count}=num2str(sort([IP_p other_points_vic]));
            end;   
            
       end;
       
    end;
    
    clustered_sets=unique(clustered_sets);

    for N_min=2:num_subjects;
        
        new_clustered_sets = refine_clustered_sets(clustered_sets, N_min, radius_tol, all_marked_IP, D_marked_IP);
        final_GT_points = median_of_clusters(new_clustered_sets, all_marked_IP, D_marked_IP);
        GT_MODEL{rrr,N_min-1,1} = final_GT_points;
        GT_MODEL{rrr,N_min-1,2} = new_clustered_sets;
        
    end;

end;
    
    