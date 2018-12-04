%% Exemplo do caderno
clear
G=automaton('G');
G.addState('1',0,1,{'sf' 'a'},{'2' '7'},[0,1]);
G.addState('2',0,0,{'a'},{'3'});
G.addState('3',0,0,{'b'},{'4'});
G.addState('4',0,0,{'g'},{'5'});
G.addState('5',0,0,{'t'},{'6'});
G.addState('6',0,0,{'t'},{'6'});
G.addState('7',0,0,{'sf' 'b'},{'8' '11'});
G.addState('8',0,0,{'b'},{'9'});
G.addState('9',0,0,{'g'},{'10'});
G.addState('10',0,0,{'d'},{'3'});
G.addState('11',0,0,{'g'},{'12'});
G.addState('12',0,0,{'d'},{'7'});
Gd=diagnoser(G);
%% Changing Sigma_o and Sigma_f
Sigma_f={'sf' 't'};
Sigma_o=setdiff(G.alphabet,Sigma_f);
Gd=diagnoser(G,Sigma_f,Sigma_o)