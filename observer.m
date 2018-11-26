function Gobs=observer(G)
Gobs=automaton('Gobs');
uo=G.unobservable;
Gobs.alphabet=setdiff(G.alphabet,uo);
X={};
X{1}=G.init_states;
init=1;
while not(isempty(X))
    for j=1:length(X)                  %group by group
        Xj=sort(unique(X{j}));
        X_name=strjoin(Xj,',');
        marked=0;
        Tr={};
        Next={};
        Xi=unobsv_reach(G,Xj);
        for i=1:length(Xj)            %state by state
            x=G.getState(char(Xi(i)));
            marked=marked+x.marked;
            tr=x.transitions;
            next=x.next;
            iuo=ismember(tr,uo);
            tr=tr(not(iuo));            %%%%%%*********
            next=next(not(iuo));
            [LIA,LOCB] = ismember(tr,Tr);
            if not(all(LIA))
                Tr=enqueue(Tr,tr(not(LIA)));   %add new transitions
                Next=enqueue(Next,next(not(LIA)));
            end
            if any(LIA)
                LOCB(LOCB==0)=[];              %add states to existing transitions
                Next(LOCB)={Next(LOCB),next(LIA)};
            end
        end
        
        xobs=Gobs.addState(X_name,boolean(marked),init);
        for k=1:length(Tr)
            nextk=Next{k};
            if ischar(nextk)
                xobs.addTransition(Tr(k),nextk)
            else
                xobs.addTransition(Tr(k),strjoin(nextk,','))
            end
        end
    end
    init=0;
    X=Next;
end


end