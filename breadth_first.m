function varargout=breadth_first(G,init)
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
    s=start{i};
    u=G.getState(s);
    u.color='g';
    u.d=0;
    u.predecessor=[];
end
while not(isempty(Q))
    [s,Q] = dequeue(Q);
    u=G.getState(s);
    next=u.next;
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
if nargout>0
    varargout{1}=X;
    if nargout>1
        varargout{2}=d_all;
        if nargout>2
            varargout{3}=setdiff(G.getStateNames,X);
        end
    end
end

