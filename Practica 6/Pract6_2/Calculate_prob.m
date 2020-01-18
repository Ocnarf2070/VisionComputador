function prob=Calculate_prob(class,digits)
    eq=class'==digits;
    prob=sum(eq)*100/length(eq);
end