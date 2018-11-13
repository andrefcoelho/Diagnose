function S=topological_sort(G)
S={};
depth_first(G);
n=length(G.states);
names=cell(1,n);
f_all=zeros(1,n);
for i=1:n
    f_all(i)=G.states{i}.f;
    names{i}=G.states{i}.name;
end
[~,i]=sort(f_all,'descend');
S=names(i);