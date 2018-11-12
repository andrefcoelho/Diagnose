clear
name='G';
G=automaton(name)
marked=0;
initial=1;
transitions={'a','b','c'};
next={'X1','X2','X4'};
G.addState('X1',marked,initial,transitions,next)
G.addState('X2',1,1)
G.addState('X3')
G.addState('X4')
x1=G.getState(1)
[x2,n]=G.getState('X2');
X=G.getAllStates;
x3=X{3};
x2.addTransition('Sigmaf','X3')
G.markState('X3',1)
G.initialState('X3',1)
namesG=getStateNames(G)
G1=copy(G);
G1.removeStates({'X2' 'X4'})
namesG1=getStateNames(G1)

