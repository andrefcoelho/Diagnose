function Al=create_AL(Sigma_f)
Sf={};
if ischar(Sigma_f)
    Sf{1}=Sigma_f;
else
    Sf=Sigma_f;
end
Al=automaton('Al');
N=Al.addState('N',0,1);
F=Al.addState('F');
for i=1:length(Sf)
    tr=Sf(i);
    N.addTransition(tr,{'F'})
    F.addTransition(tr,{'F'})
end