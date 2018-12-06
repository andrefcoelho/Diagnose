function d=max_delay(Gv,Sigma)
Gv=copy(Gv);
for i=1:length(Gv.states)
    n = strfind(Gv.states{i}.name,',N');
    f = strfind(Gv.states{i}.name,',F');
    if not(isempty(n) || isempty(f))
        Gv.markState(i,1);
    end
end
