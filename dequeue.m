function [s,Q] = dequeue(Q)
if isempty(Q)
    s=[];
else
    s=Q{1};
    Q=Q(2:end);
end
end
