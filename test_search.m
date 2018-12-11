clear
%% Breadth-first search
clear G
name='G';
G=automaton(name);
G.addState('X5',0,1,{'a','b','c','d'},{'X1','X2','X3','X5'});
G.addState('X2',0,0,{'a'},{'X5'});
G.addState('X3',0,0,{'a','b'},{'X4','X5'});
G.addState('X4',0,0,{'a','b'},{'X5','X6'});
G.addState('X1',0,1);
G.addState('X6');
G.addState('X7',1,0,{'a'},{'X8'});  %not accessible
G.addState('X8',0,0);  %not accessible
[Xb1,d1,Xinf]=breadth_first(G)  %starting from initial states
start='X3';
[Xb2,d2]=breadth_first(G,start) %starting from chosen state

%% Accessible part
namesG=getStateNames(G)
G_acc=accessible(G);
namesGacc=getStateNames(G_acc)

%% Depth-first search
clear G1
G1=automaton('G1');
G1.addState('u',0,0,{'a' 'a'},{'v' 'x'});
G1.addState('v',0,0,{'a'},{'y'});
G1.addState('x',0,0,{'a'},{'v'});
G1.addState('y',0,0,{'a'},{'x'});
G1.addState('w',0,0,{'a' 'a'},{'z' 'y'});
G1.addState('z',0,0,{'a'},{'z'});
DFT=depth_first(G1)
%% Topological sort
clear G3
G3=automaton('G3')
G3.addState('undershorts',0,0,{'a' 'a'},{'pants' 'shoes'});
G3.addState('pants',0,0,{'a' 'b'},{'belt' 'shoes'});
G3.addState('belt',0,0,{'a'},{'jacket'});
G3.addState('shirt',0,0,{'a' 'a'},{'belt' 'tie'});
G3.addState('tie',0,0,{'a'},{'jacket'});
G3.addState('jacket');
G3.addState('socks',0,0,{'a'},{'shoes'});
G3.addState('shoes');
G3.addState('watch');
[S,s_index]=topological_sort(G3)

%% Coaccessible part
clear G2
G2=automaton('G2');
G2.addState('X1',0,1,{'a' 'b'},{'X2' 'X1'});
G2.addState('X2',0,0,{'a' 'b'},{'X3' 'X4'});
G2.addState('X3',0,0,{'a'},{'X6'});
G2.addState('X4',0,0,{'a'},{'X5'});  %not coaccessible
G2.addState('X5',0,1);               %not coaccessible
G2.addState('X6',1);
namesG2=getStateNames(G2)
G2coacc=coaccessible(G2);
namesG2coacc=getStateNames(G2coacc)

%% Strongly-connected elements
clear G5
G5=automaton('G5');
G5.addState('A',0,1,{'-'},{'B'});
G5.addState('B',0,0,{'-' '-' '-'},{'C' 'E' 'F'});
G5.addState('C',0,0,{'-' '-'},{'D' 'G'});
G5.addState('D',0,0,{'-' '-'},{'C' 'H'});
G5.addState('E',0,0,{'-' '-'},{'A' 'F'});
G5.addState('F',0,0,{'-'},{'G'});
G5.addState('G',0,0,{'-' '-'},{'F' 'H'});
G5.addState('H',0,0,{'-'},{'H'});
SC = strongly_connected(G5)
%% Test Gdag
Gdag=dag(G5)