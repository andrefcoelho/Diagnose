clear
G=automaton('G');
G.addState('0',0,1,{'a'},{'1'});
G.addState('1',0,0,{'b' 'c' 'sf'},{'2' '2' '3'},[1 1 0]);
G.addState('2',0,0,{'a' 'c'},{'2' '2'});
G.addState('3',0,0,{'b'},{'4'});
G.addState('4',0,0,{'c'},{'5'});
G.addState('5',0,0,{'a'},{'6'});
G.addState('6',0,0,{'su'},{'6'},0);
Sigma_f='sf';
Sigma_o1={'a' 'b'};
Sigma_o2={'a' 'c'};
Sigma_o={Sigma_o1 Sigma_o2}
Gv=verifier(G,Sigma_f,Sigma_o)

%%
clear G
G=automaton('G');
G.addState('0',0,1,{'a'},{'1'});
G.addState('1',0,0,{'b' 'sf'},{'5' '2'},[1 0]);
G.addState('2',0,0,{'b'},{'3'});
G.addState('3',0,0,{'su1'},{'4'},0);
G.addState('4',0,0,{'a'},{'4'});
G.addState('5',0,0,{'su2'},{'6'},0);
G.addState('6',0,0,{'su3' 'a'},{'5' '7'},[0 1]);
G.addState('7',0,0,{'b'},{'7'});
Sigma_f='sf';
Sigma_o={'a' 'b'};
Gv=verifier(G,Sigma_f,Sigma_o)