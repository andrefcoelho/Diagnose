function varargout=depth_first(varargin)
G=varargin{1};
global DFT
DFT={};
global time
time=0;
n=length(G.states);
for i=1:n
    G.states{i}.color='w';
    G.states{i}.predecessor=[];
end
if nargin>1
    order=varargin{2};
else
    order=1:n;
end
for i=1:n
    if G.states{order(i)}.color=='w';
        dfs_visit(G,G.states{order(i)});
        DFT=[DFT '|'];
    end
end
if nargout>0
    varargout{1}=DFT;
end
end
function dfs_visit(G,u)
global DFT
global time
time=time+1;
DFT=[DFT u.name];
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

