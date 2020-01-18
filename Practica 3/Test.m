n=randn(size(imL,1),size(imL,2));
m=zeros(length(Lx),1);
for i=1:length(Lx)
    x=Ly(i);
    y=Lx(i);
    m(i)=n(x,y); 
end