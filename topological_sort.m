function varargout=topological_sort(G)
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
index=[1:n];
sort_index=index(i);
varargout{1}=S;
if nargout>1
    varargout{2}=sort_index;
end