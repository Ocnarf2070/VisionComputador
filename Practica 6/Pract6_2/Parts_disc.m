function [wf wn] = Parts_disc(pf,ck)
    wf=log(pf./(1-pf));
    pf=reshape(pf,[1 size(pf,1)*size(pf,2)]);
    wn=log(ck)+sum(log(1-pf));
end