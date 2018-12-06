function Gb=keep_marked(G)
Gb=copy(G);
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
toRemove={};
for i=1:length(Gb.states)
    st=Gb.states{i};
    if not(st.marked)
        if st.initial
            next=st.next;
            for j=1:length(next)
                next_state=Gb.getState(next{j});
                Gb.initialState(next_state.name,1)
            end
        end
        toRemove=union(toRemove,st.name); 
    end
end
Gb.removeStates(toRemove)