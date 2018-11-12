function X=breadth_first(G,init)
if nargin==1
    states=G.init_states;
else
    states{1}=init;
end
X=states;
done=0;
next={};
while not(done)
    if not(isempty(states))
        for i=1:length(states)
            next=[next G.getState(states{i}).next];
        end
        states=setdiff(next,X,'stable');
        X=[X states];
%         X=[X '|' states];
        next={};
    else
        done=1;
    end
end