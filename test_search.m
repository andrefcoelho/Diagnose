clear
%% Breadth-first search
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
show=1;
Xb1=breadth_first(G,show);  %starting from initial states
disp('---------------------------------')
Xb2=breadth_first(G,show,start); %starting from chosen state

%% Accessible part
namesG=getStateNames(G)
G_acc=accessible(G)
namesGacc=getStateNames(G_acc)

%% Depth-first search
G1=automaton('G1');
G1.addState('u',0,0,{'a' 'a'},{'v' 'x'});
G1.addState('v',0,0,{'a'},{'y'});
G1.addState('x',0,0,{'a'},{'v'});
G1.addState('y',0,0,{'a'},{'x'});
G1.addState('w',0,0,{'a' 'a'},{'z' 'y'});
G1.addState('z',0,0,{'a'},{'z'});
Xd=depth_first(G1);