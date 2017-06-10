function V_IP = map_user_IP_to_vertices(IP,V)

num_IP = size(IP,1);
V_IP=zeros(num_IP,1);

for i=1:num_IP;
    v_IP = get_closest_vertex(V,IP(i,1:3));
    V_IP(i)=v_IP;
end;