function X=breadth_first(G,show,init)
if nargin<3
    states=G.init_states;
    if nargin<2
        show=0;
    end
else
    states{1}=init;
end

X=states;
done=0;
next={};
d=0;
while not(done)
    if not(isempty(states))
        for i=1:length(states)
            if show
            disp(strcat('State:',states(i),' d=',num2str(d)));
            end
            next=[next G.getState(states{i}).next];
        end
        states=setdiff(next,X,'stable');
        X=[X states];
%         X=[X '|' states];
        next={};
    else
        done=1;
    end
    d=d+1;
end