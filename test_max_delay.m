clear 
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
Gv=verifier(G,Sigma_f,Sigma_o);
Sigma=G.alphabet;
max_d=max_delay(Gv,Sigma)