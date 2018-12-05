function An=create_An(Sigma,Sigma_f)
An=automaton('An');
tr=setdiff(Sigma,Sigma_f);
next=cell(size(tr));
next(1:end) = {'N'};
An.addState('N',0,1,tr,next);

