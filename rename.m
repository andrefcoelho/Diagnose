function Gr=rename(G,Sigma_o,Sigma_f,index)
if nargin<3
    index=1;
end
Gr=copy(G);
Sigma_uo=setdiff(G.alphabet,Sigma_o);
Sigma_uo=setdiff(Sigma_uo,Sigma_f);
for i=1:length(Gr.states)
    st=Gr.states{i};
    for j=1:length(st.transitions)
        if ismember(st.transitions{j},Sigma_uo)
            new_tr=strcat(st.transitions{j},'R',num2str(index));
            st.transitions{j}=new_tr;
            Gr.alphabet=union(Gr.alphabet,new_tr);
        end
    end
end