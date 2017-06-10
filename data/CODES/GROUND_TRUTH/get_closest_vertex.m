function I = get_closest_vertex(V,I_point)

d=sum((V'-repmat(I_point(:),1,length(V))).^2);

[dummy, I]=min(d);