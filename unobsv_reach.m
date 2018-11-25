function Xuo=unobsv_reach(G,init)
if nargin<2
    start=G.init_states;
else
    start{1}=init;
end
X={};
d_all=[];
for i=1:length(G.states)
    u=G.states{i};
    u.color='w';
    u.d=inf;
    u.predecessor=[];
end
Q={};
Q=enqueue(Q,start);
for i=1:length(start)
    s=start(i);
    G.getState(char(s)).color='g';
    G.getState(char(s)).d=0;
    G.getState(char(s)).predecessor=[];
end
while not(isempty(Q))
    [s,Q] = dequeue(Q);
    u=G.getState(s);
    tr=u.transitions;
    [~,iu]=intersect(tr,G.unobservable);  %only change
    next=u.next(iu);
    for i=1:length(next)
        v=G.getState(char(next(i)));
        if v.color=='w'
            v.color='g';
            v.d=u.d+1;
            v.predecessor=u.name;
            Q=enqueue(Q,v.name);
        end
    end
    u.color='b';
    X=[X u.name];
    d_all=[d_all u.d];
end
Xuo=X;
end

