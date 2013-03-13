clear all;

cd csv;
csvimport('xspeaker.csv');
xrmb=ans;
clear ans;
cd ..;

save('xspeaker.mat');

lemcells=(xrmb(:,5));
ccmcells=(xrmb(:,6));
remcells=(xrmb(:,7)); 

n=length(remcells);

lemvec=zeros(n-1,1); %preallocate array
ccmvec=zeros(n-1,1); %preallocate array
remvec=zeros(n-1,1); %preallocate array

for i=1:n-1
    lemvec(i,1)=cell2mat(lemcells(i+1)); %extracting lem vector
end;

for i=1:n-1
    ccmvec(i,1)=cell2mat(ccmcells(i+1)); %extracting ccm vector
end;

for i=1:n-1
    remvec(i,1)=cell2mat(remcells(i+1)); %extracting rem vector
end;

composite=zeros(n-1,3);

composite(:,1)=lemvec;
composite(:,2)=ccmvec;
composite(:,3)=remvec;

stds=std(composite);
means=sum(composite)/length(composite);

rsds=zeros(1,3); % preallocate

for i=1:3
    rsds(i)=stds(i)*(1/means(i));
end;

clear i n;