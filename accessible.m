function G_acc=accessible(G)
X_acc=breadth_first(G);
G_acc=copy(G);
X_all=getStateNames(G);
G_acc.removeStates(setdiff(X_all,X_acc))

