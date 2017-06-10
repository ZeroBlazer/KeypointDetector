function new_clustered_sets = refine_clustered_sets(clustered_sets, N_min, radius_tol, all_marked_IP, D_marked_IP)

new_clustered_sets = clustered_sets;

for i=1:length(clustered_sets);
    set_i=str2num(clustered_sets{i});
    if length(set_i) < N_min
        new_clustered_sets = setdiff(new_clustered_sets,clustered_sets(i));
    end;
end;

c_sets = new_clustered_sets;

for i=1:length(c_sets);
    set_i=str2num(c_sets{i});
    
    Ind_s = zeros(length(set_i),1);
    for p=1:length(set_i);
        p_point = set_i(p);
        Ind_s(p) = find(all_marked_IP==p_point);
    end;
    
    Ind_s = unique(Ind_s);
    
   
    for p=1:length(Ind_s);
        d=D_marked_IP(Ind_s,Ind_s(p));
        if max(d) > 2*radius_tol;
            new_clustered_sets = setdiff(new_clustered_sets,c_sets(i));
            break;
        end;
    end;
end;


c_sets=new_clustered_sets;

flag_subset=[];
count=0;

for i=1:length(c_sets);
    set_i = str2num(c_sets{i});
    
    for j=1:length(c_sets);
        if not(i==j);
            set_j = str2num(c_sets{j});
            set_diff = setdiff(set_j,set_i);
            if isempty(set_diff);
                count=count+1;
                flag_subset(count)=j;
            end;
        end;
    end;
end;

new_sets = setdiff([1:length(c_sets)],flag_subset);

new_clustered_sets=c_sets(new_sets);
            
    
    
    
    

