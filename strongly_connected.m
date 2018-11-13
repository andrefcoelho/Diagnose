function C = strongly_connected(G)
[S,s_index]=topological_sort(G)
G_t=G.invert;
C=depth_first(G_t,s_index)
end

