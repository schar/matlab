close all; clear all;   
randn('state',0); %reset the random number generator

%load data (dataset must define 'datacell')
run('data2');

%number of stimuli types (wordtype-speaker pairs)
types = length(datacell);

%number of simulations
simN = 1000;

%preallocate arrays
rems = zeros(simN,types);
ccms = zeros(simN,types);

%main loop
for count=1:simN
    permd=datacell(randperm(types)); %shuffles datacell
    cumulator=[]; %empty starting cumulator array
    for lexicon=1:types 
        for place=1:lexicon
            cumulator=cat(2,cumulator,cell2mat(permd(place))); 
        end;
        summed=sum(cumulator,2);
        [h w]=size(cumulator);
        avg=summed/w;
        avgREM=avg(1); 
        avgCCM=avg(2);
        stdREM=std(cumulator(1,:));
        stdCCM=std(cumulator(2,:));
        rsdREM=(1+1/(4*w))*(stdREM/avgREM);
        rsdCCM=(1+1/(4*w))*(stdCCM/avgCCM);
        rems(count,lexicon)=rsdREM;
        ccms(count,lexicon)=rsdCCM;
        cumulator=[]; %resets cumulator
    end;
end; %end main loop

%averaging sims
remarray = sum(rems,1)/simN;
ccmarray = sum(ccms,1)/simN;

%graph
x=1:types;
plot(x, remarray, 'r-', x, ccmarray, 'k--');