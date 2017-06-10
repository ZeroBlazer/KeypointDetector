function final_GT_points = median_of_clusters(c_sets,all_marked_IP,D_marked_IP)

final_GT_points=zeros(length(c_sets),1);

for i=1:length(c_sets);
    set_i=str2num(c_sets{i});
    
    Ind_s = zeros(length(set_i),1);
    for p=1:length(set_i);
        p_point = set_i(p);
        Ind_s(p) = find(all_marked_IP==p_point);
    end;
    
    D_matrix = zeros(length(set_i),length(set_i));
    
    for p=1:length(set_i);
        d=D_marked_IP(Ind_s,Ind_s(p));
        D_matrix(:,p)=d(:);
    end;
    
    [dummy II] = min(sum(D_matrix));
    final_GT_points(i) = set_i(II);
    
end;
