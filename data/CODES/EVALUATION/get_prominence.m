function PRO_GT = get_prominence(GT_MODEL)

rtf = size(GT_MODEL,1);
num_subjects = size(GT_MODEL,2)+1;
    
PRO_GT = cell(rtf,num_subjects-1);
    
for rrr=1:rtf;
    for N_min=2:num_subjects; 
        
        final_GT_points = GT_MODEL{rrr,N_min-1,1};
        SS = GT_MODEL{rrr,N_min-1,2};
        
        pro_IP = zeros(length(final_GT_points),1);

        for g=1:length(final_GT_points);
    
            Set_g = SS{g};
            Set_g = str2num(Set_g);
            pro_IP(g) = length(Set_g);
      
        end;
            
        PRO_GT{rrr,N_min-1} = pro_IP;
    
    end;
end;

