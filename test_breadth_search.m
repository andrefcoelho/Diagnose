clear
name='G';
G=automaton(name);
G.addState('X5',0,1,{'a','b','c'},{'X1','X2','X3'});
G.addState('X2',0,0,{'a'},{'X5'});
G.addState('X3',0,0,{'a','b'},{'X4','X5'});
G.addState('X4',0,0,{'a','b'},{'X5','X6'});
G.addState('X1',0,1);
G.addState('X6');
G.addState('X7',1);  %not accessible
start='X3';
Xb1=breadth_first(G)  %starting from initial states
Xb2=breadth_first(G,start) %starting from chosen state
namesG=getStateNames(G)
G_acc=accessible(G)
namesGacc=getStateNames(G_acc)