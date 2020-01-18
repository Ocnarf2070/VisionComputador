function n = Change_prob(n)
for i=1:28
    for j=1:28
        if n(i,j)==0
            n(i,j)=0.0001;
        else
            if n(i,j)==1
                n(i,j)=0.9999;
            end
        end
    end
end
end
