clear
G1=automaton('G1');
G1.addState('1',1,1,{'a','c'},{'2','1'});
G1.addState('2',0,0,{'b'},{'2'});
G2=automaton('G2');
G2.addState('A',1,1,{'a','b'},{'B','A'});
G2.addState('B',1,0,{'d'},{'B'});
Gprod = product(G1,G2)
Gpar = parallel(G1,G2)  

%% Product - example 2.19 Cassandras
clear
G1=automaton('G1');
G1.addState('X1',0,1,{'a1','a2'},{'X2','X2'});
G1.addState('X2',0,0,{'b'},{'X3'});
G1.addState('X3',0,0,{'r'},{'X1'});

G2=automaton('G2');
G2.addState('Y1',0,1,{'a1','a2'},{'Y2','Y3'});
G2.addState('Y2',0,0,{'b'},{'Y4'});
G2.addState('Y3',0,0,{'b'},{'Y5'});
G2.addState('Y4',0,0,{'r','c1'},{'Y1','Y6'});
G2.addState('Y5',0,0,{'r','c2'},{'Y1','Y6'});
G2.addState('Y6',0,0,{'r'},{'Y1'});

Gprod = product(G1,G2)
Gpar = parallel(G1,G2)  %should be the same as Gprod