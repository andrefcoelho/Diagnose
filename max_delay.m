function dmax=max_delay(Gv,Sigma)
Gv=copy(Gv);
for i=1:length(Gv.states)
    n = strfind(Gv.states{i}.name,',N');
    f = strfind(Gv.states{i}.name,',F');
    if not(isempty(n) || isempty(f))
        Gv.markState(i,1);
    end
end
Gv=keep_marked(Gv);
Gv=dag(Gv);
s=topological_sort(Gv);
for i=1:length(Gv.states)
    Gv.states{i}.d=0;
end
dmax=0;
for i=1:length(s)
    st=Gv.getState(s{i});
    d=st.d;
    tr=st.transitions;
    next=st.next;
    for j=1:length(tr)
        [~,k]=intersect(tr{j},Sigma);
        next_state=Gv.getState(next{j});
        dn=max(next_state.d,d+(not(isempty(k))));
        next_state.d=dn;
        dmax=max(dmax,dn);
    end
end



