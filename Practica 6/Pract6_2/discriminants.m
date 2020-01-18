function dx = discriminants(wf,wn,x)
    wf=reshape(wf,[1 size(wf,1)*size(wf,2)]);
    x=(reshape(x,[1 size(x,1)*size(x,2)]))~=0;
    p = sum(wf.*x);
    dx=wn+p;
end