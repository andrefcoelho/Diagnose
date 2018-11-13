function X=depth_first(G)
for i=1:length(G.states)
    G.states{i}.color='w';
    G.states{i}.predecessor=[];
end
global time
time=0;
for i=1:length(G.states)
    if G.states{i}.color=='w';
        dfs_visit(G,G.states{i});
    end
end
X=0;
end
function dfs_visit(G,u)
global time
time=time+1;
u.d=time;
u.color='g';
next=u.next;
for i=1:length(next)
    v=G.getState(char(next(i)));
    if v.color=='w';
        v.predecessor=u;
        dfs_visit(G,v);
    end
end
u.color='b';
time=time+1;
u.f=time;

end

