%% Example 2.21 Cassandras
clear
G=automaton('G');
G.addState('0',1,1,{'a'},{'1'});
G.addState('1',0,0,{'b','b','epsl'},{'0','1','2'},[1 1 0]);
G.addState('2',0,0,{'a','epsl'},{'0','3'});
G.addState('3',0,0,{'b'},{'0'});
Gobs=observer(G)

%% Example to show markers
Gobs.unobservable={'b'}
Gobs1=observer(Gobs)
%% Example 2 to show markers
Gobs1.unobservable={'a'}
Gobs2=observer(Gobs1)