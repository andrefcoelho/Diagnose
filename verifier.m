function Gv=verifier(G,Sigma_f,Sigma_o)
Al=create_AL(Sigma_f);
An=create_An(G.alphabet,Sigma_f);
Gn=product(G,An);
Gn.alphabet=setdiff(Gn.alphabet,Sigma_f);
Gl=parallel(G,Al);
for i=1:length(Gl.states)
    st=Gl.states{i};
    name=st.name;
    if strcmp(name(end),'F')
        Gl.markState(i,1);
    end
end
Gf=coaccessible(Gl);
GN={};
if iscell(Sigma_o{1})
    for i=1:length(Sigma_o)
        GN{i}=rename(Gn,Sigma_o{i},Sigma_f,i);
    end
else
    GN{1}=rename(Gn,Sigma_o,Sigma_f,1);
end
Gn=GN{1};
if length(GN)>1
    for i=2:length(GN)
        Gn=parallel(Gn,GN{i});
    end
end
Gv=parallel(Gn,Gf);
Gv.name='Gv';