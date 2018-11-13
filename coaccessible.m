function G_coacc=coaccessible(G)
G_inv=G.invert;
G_aux=accessible(G_inv);
G_coacc=G_aux.invert;



