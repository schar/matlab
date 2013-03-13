close all; clear all;   
randn('state',0); %reset the random number generator

%load data (dataset must define 'datacell')
run('data');

%number of stimuli types (wordtype-speaker pairs)
types = length(datacell);

cumulator=[]; %empty starting cumulator array

for place=1:types
    cumulator=cat(2,cumulator,cell2mat(datacell(place))); 
end;

summed=sum(cumulator,2);
avg=summed/(length(cumulator));
avgREM=avg(1); 
avgCCM=avg(2);
stds=std(cumulator,0,2);
stdREM=stds(1);
stdCCM=stds(2);
rsdREM=stdREM/avgREM;
rsdCCM=stdCCM/avgCCM;