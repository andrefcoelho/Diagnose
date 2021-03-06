function Gprod = product(G1,G2)

%defining state delimiter
markers=[44 59 45:47 60:63 91:95 123:126]; %possible state delimiters in ASCII
i=1;
while ismember(char(markers(i)),strcat(strjoin(G1.getStateNames),strjoin(G2.getStateNames)));
    i=i+1;
end
marker=char(markers(i));

Gprod=automaton(strcat(G1.name,'x',G2.name));
Gprod.alphabet=union(G1.alphabet,G2.alphabet);
Gpar.unobservable=union(G1.unobservable,G2.unobservable);

pind=0;
for i=1:length(G1.states)
    for j=1:length(G2.states)
        pind=pind+1;
        %cartesian product
        s1=G1.states{i};
        s2=G2.states{j};
        sprod=strcat(s1.name,marker,s2.name);
        marked=s1.marked*s2.marked;      %check
        initial=s1.initial*s2.initial;
        Gprod.addState(sprod,marked,initial)
        %defining transitions
        tr1=s1.transitions;
        tr2=s2.transitions;
        n1=s1.next;
        n2=s2.next;
        tr = intersect(tr1,tr2);
        if not(isempty(tr))
            [~,i1] = ismember(tr,tr1);               % assuming deterministic automata
            [~,i2] = ismember(tr,tr2);
            assert(not(isempty(i1) || isempty(i2)));
            for k=1:length(i1)                       %same length as i2
                nprod=strcat(char(n1(i1(k))),marker,char(n2(i2(k))));
                Gprod.states{pind}.addTransition(tr{k},nprod)
            end
        end
    end
end
Gprod=accessible(Gprod);
end

