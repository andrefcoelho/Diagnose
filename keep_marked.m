function Gb=keep_marked(G)
Gb=copy(G);
while not(all(ismember(Gb.init_states,Gb.marked_states)))  %trim normal initial states
    toRemove={};
    for i=1:length(Gb.init_states)
        st=Gb.getState(Gb.init_states{i});
        if not(st.marked)
            next=st.next;
            %%
            for j=1:length(next)
                next_state=Gb.getState(next{j});
                Gb.initialState(next_state.name,1);
            end
            toRemove=union(toRemove,st.name);
        end
    end
    Gb.removeStates(toRemove);
end
toRemove={};
for i=1:length(Gb.states)          %remove remaining non-marked sta
    st=Gb.states{i};
    if not(st.marked)
        toRemove=union(toRemove,st.name);
    end
end
Gb.removeStates(toRemove)