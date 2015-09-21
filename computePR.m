function pr = computePR(scores, labels)

% From the PASCAL VOC 2011 devkit
% compute precision/recall

[so,si] = sort(-scores);
tp=labels(si)>0;
fp=labels(si)<0;

fp=cumsum(fp);
tp=cumsum(tp);
rec=tp/sum(labels>0);
prec=tp./(fp+tp);

ap=VOCap(rec,prec);

pr.rec = rec;
pr.prec = prec;
pr.ap = ap;


function ap = VOCap(rec,prec)
% From the PASCAL VOC 2011 devkit

mrec=[0 ; rec ; 1];
mpre=[0 ; prec ; 0];
for i=numel(mpre)-1:-1:1
    mpre(i)=max(mpre(i),mpre(i+1));
end
i=find(mrec(2:end)~=mrec(1:end-1))+1;
ap=sum((mrec(i)-mrec(i-1)).*mpre(i));

