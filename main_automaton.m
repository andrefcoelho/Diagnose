clear
name='G';
a=automaton(name)
marked=0;
initial=1;
transitions={'a','b'};
next={'X1','X2'};
a.addState('X1',marked,initial,transitions,next)
a.addState('X2',0)
a.addState('X3')
x1=a.getState(1)
x2=a.getState('X2')
X=a.getAllStates
x3=X{3}
x2.addTransition('Sigmaf','X3')
a.markState('X3',1)
a.initialState('X3',0)


