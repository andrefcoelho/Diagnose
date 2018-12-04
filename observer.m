function Gobs=observer(G,obs_events)
if nargin>1
    G=copy(G);
    uo=setdiff(G.alphabet,obs_events);
    G.unobservable=uo;
else
    uo=G.unobservable;
end

if isempty(uo)
    Gobs=copy(G);
    Gobs.name='Gobs';
else
    
    %defining state delimiter
    markers=[44 59 45:47 60:63 91:95 123:126]; %possible state delimiters in ASCII
    i=1;
    while ismember(char(markers(i)),strjoin(G.getStateNames));
        i=i+1;
    end
    marker=char(markers(i));
    if isempty(G.init_states)
        warning('Automaton has no initial states. Setting initial state to be the first state in the list.')
        G.init_states{1}=G.states{1}.name;
    end
    Gobs=automaton('Gobs');
    Gobs.alphabet=setdiff(G.alphabet,uo);
    Next_all={};
    X_all{1}=strjoin(unobsv_reach(G),marker);
    init=1;
    
    
    while not(isempty(X_all))
        for j=1:length(X_all)                  %group by group
            Xj=unique(strsplit(X_all{j},marker));
            if not(ismember(X_all{j},Gobs.getStateNames))
                marked=0;
                Tr={};
                Next={};
                for i=1:length(Xj)            %state by state
                    x=G.getState(char(Xj(i)));
                    marked=marked+x.marked;
                    tr=x.transitions;
                    next=x.next;
                    iuo=ismember(tr,uo);
                    tr=tr(not(iuo));
                    next=next(not(iuo));
                    [LIA,LOCB] = ismember(tr,Tr);
                    if not(all(LIA))
                        [new_tr,idx]=unique(tr(not(LIA)));
                        new_next=next(idx);
                        Tr=enqueue(Tr,new_tr);   %add new transitions
                        Next=enqueue(Next,new_next);
                        if(length(idx)~=length(tr)) %new duplicate transitions
                            tr(idx)='';  %%remove duplicate transitions
                            next(idx)='';
                            [LIA,LOCB] = ismember(tr,Tr);
                        end
                    end
                    if any(LIA)
                        LOCB(LOCB==0)=[];              %add states to existing transitions
                        for n=1:length(LOCB)
                            if not(ismember(next{LIA(n)},strsplit(Next{LOCB(n)},marker)))
                                Next{LOCB(n)} = strcat(Next{LOCB(n)},marker, next{LIA(n)});
                            end
                        end
                    end
                end
                
                xobs=Gobs.addState(X_all{j},boolean(marked),init);
                for k=1:length(Tr)
                    nextk=unique(unobsv_reach(G,strsplit(Next{k},marker)));
                    nextk=strjoin(nextk,marker);
                    %                 nextk=strjoin(unique(strsplit(nextk,marker)),marker);
                    Next_all{end+1}=nextk;
                    xobs.addTransition(Tr(k),nextk);
                end
            end
        end
        init=0;
        X_all=Next_all;
        Next_all={};
    end
end
end