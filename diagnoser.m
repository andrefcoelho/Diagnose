function Gd=diagnoser(G,Sigma_f,Sigma_o)
if nargin<2
    warning('Sigma_f not specified. Using unobservable events as fault events')
    Sigma_f=G.unobservable;
end
Al=create_AL(Sigma_f);
Gl=parallel(G,Al);
if nargin>2
    Gd=observer(Gl,Sigma_o);
else
    Gd=observer(Gl);
end 
Gd.name='Gd';
end
