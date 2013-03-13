close all; clear all;   
randn('state',0); %reset the random number generator

%load data (dataset must define 'datacell')
run('data2');

%number of stimuli types (wordtype-speaker pairs)
types = length(datacell);

%number of simulations
simN = factorial(types);

%preallocate arrays
rems = zeros(simN,types);
ccms = zeros(simN,types);

all = perms(datacell);

%main loop
for count=1:simN
    permd=all(count,1:types);
    cumulator=[]; %empty starting cumulator array
    for lexicon=1:types 
        for place=1:lexicon
            cumulator=cat(2,cumulator,cell2mat(permd(place))); 
        end;
        summed=sum(cumulator,2);
        avg=summed/(length(cumulator));
        avgREM=avg(1); 
        avgCCM=avg(2);
        stdREM=std(cumulator(1,1:length(cumulator)));
        stdCCM=std(cumulator(2,1:length(cumulator)));
        rsdREM=stdREM/avgREM;
        rsdCCM=stdCCM/avgCCM;
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