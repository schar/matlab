close all; clear all;   
randn('state',0); %reset the random number generator

simN = 50000; %number of simulations

everyone = ['a' 'c' 'o']; %AB,CZ,OB segregations

remavgs = zeros(3,9); %3 speakers X 9 lexica
ccmavgs = zeros(3,9); %3 speakers X 9 lexica

for speaker=1:length(everyone)
    clear datacell;
    run(everyone(speaker)); %load data (each dataset must define 'datacell')
    types = length(datacell); %number of stimuli types (word types pairs)
    rems = zeros(simN,types);
    ccms = zeros(simN,types); %preallocate arrays
    for count=1:simN %main loop
        permd=datacell(randperm(types)); %shuffles datacell
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
    remarray = sum(rems,1)/simN;
    ccmarray = sum(ccms,1)/simN; %averaging sims
    remavgs(speaker,1:9) = remarray(1:9);
    ccmavgs(speaker,1:9) = ccmarray(1:9);
end;

cumrem = sum(remavgs)/3;
cumccm = sum(ccmavgs)/3;

%graph
x=1:9;
plot(x, cumrem, 'r-', x, cumccm, 'k-');
