function Gdag=dag(G)
G1=copy(G);
SC = strongly_connected(G1);
SC=strjoin(SC,'!');
SC=strsplit(SC,'|');
for i=1:length(SC)
    states=strsplit(SC{i},'!');
    for j=1:length(states)
        if not(isempty(states{j}))
            st=G1.getState(states{j});
            next=st.next;
            [~,is] = intersect(next,states);
            tr=st.transitions(is);
            for k=1:length(tr)
                new_tr=strcat(tr{k},'#',num2str(i));
                st.transitions{is(k)}=new_tr;
                G1.alphabet=union(G1.alphabet,new_tr);
                G1.unobservable=union(G1.unobservable,new_tr);
            end
            tr_all=st.transitions;
            [tr_obs,is]=intersect(tr_all,G.alphabet);   %renaming observable transitions
            for k=1:length(tr_obs)
                tr_old=st.transitions{is(k)};
                new_tr=st.transitions{is(k)};
                while ismember(new_tr,tr_old)
                    new_tr=strcat(new_tr,'%',num2str(rand(1)));
                    st.transitions{is(k)}=new_tr;
                    G1.alphabet=union(G1.alphabet,new_tr);
                end
            end
        end
    end
end
notdag=union(setdiff(G1.alphabet,G1.unobservable),G.unobservable);
Gdag=observer(G1,notdag);
for i=1:length(Gdag.states)
    Gdag.states{i}.transitions = strtok(Gdag.states{i}.transitions,'%');
    tr=Gdag.states{i}.transitions;
    next=Gdag.states{i}.next;
    n_tr = cellfun(@(C1,C2) [C1,C2],next,tr,'UniformOutput',false);
    [~,iu]=unique(n_tr);
    Gdag.states{i}.next=Gdag.states{i}.next(iu);
    Gdag.states{i}.transitions=Gdag.states{i}.transitions(iu);
end
Gdag.alphabet=G.alphabet;
Gdag.unobservable=G.unobservable;
Gdag.name='Gdag';


