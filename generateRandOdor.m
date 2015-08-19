function [result indi]= generateRanOdor(tar,no,trials)

% tar=[1 2 3 4];
% no=[6 7 8 9];
% trials=160;
randomNo=repmat(no,[1,0.5*trials/numel(tar)]);
random=repmat(tar,[1,0.5*trials/numel(no)]);
random=random(randperm(length(random)));
randomNo=randomNo(randperm(length(randomNo)));
z=[random randomNo];
z=z(randperm(length(z)));
[a,b]=hist(z,unique(z))
cond=true;
clusterLimit=4;
indi=zeros(size(z));

for i=1:length(z)
if intersect(z(i),tar)==z(i)
indi(i)=1;
end
end
replCount=1;
for j=1:length(z)
    if(j-1<1 | j+clusterLimit>length(z))
        continue
    end
    if(sum(indi(j:j+clusterLimit))>=clusterLimit)
    z(floor(j+clusterLimit/2))=no(mod(replCount,length(no))+1) ;
    indi(floor(j+clusterLimit/2))=0;
    replCount=replCount+1;
    end
end


for j=1:length(z)
    if(j-1<1 | j+clusterLimit>length(z))
        continue
    end
    if(sum(indi(j:j+clusterLimit))>clusterLimit )
        'clusted!'
      %break;
    end
end



result=z;
[a,b]=hist(z,unique(z))