function Gpar = parallel(G1,G2)
clear Gpar
Gpar=automaton(strcat(G1.name,'||',G2.name));
Gpar.alphabet=union(G1.alphabet,G2.alphabet);
particular1=setdiff(G1.alphabet,G2.alphabet);
particular2=setdiff(G2.alphabet,G1.alphabet);
pind=0;
for i=1:length(G1.states)
    for j=1:length(G2.states)
        pind=pind+1;
        %cartesian product
        s1=G1.states{i};
        s2=G2.states{j};
        spar=strcat(s1.name,',',s2.name);
        marked=s1.marked*s2.marked;      %check
        initial=s1.initial*s2.initial;
        Gpar.addState(spar,marked,initial)
        %defining transitions
        tr1=s1.transitions;
        tr2=s2.transitions;
        n1=s1.next;
        n2=s2.next;
        %common events
        [common,i1,i2] = intersect(tr1,tr2);    %assuming deterministic automata
        if not(isempty(common))
            assert(not(isempty(i1) || isempty(i2)));
            for k=1:length(i1)                       % same length as i2
                npar=strcat(char(n1(i1(k))),',',char(n2(i2(k))));
                Gpar.states{pind}.addTransition(common{k},npar)
            end
        end
        %particular events G1
        [part1,i1]=intersect(tr1,particular1);
        if not(isempty(part1))
            for k=1:length(i1)                       
                npar=strcat(char(n1(i1(k))),',',char(s2.name));
                Gpar.states{pind}.addTransition(part1{k},npar)
            end
        end
        
        %particular events G2
        [part2,i2]=intersect(tr2,particular2);
        if not(isempty(part2))
            for k=1:length(i2)                       
                npar=strcat(char(s1.name),',',char(n2(i2(k))));
                Gpar.states{pind}.addTransition(part2{k},npar)
            end
        end
    end
end
Gpar=accessible(Gpar);
end

