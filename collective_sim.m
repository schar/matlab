close all; clear all;   
%randn('state',0); %reset the random number generator

param = {'l1' 'l2' 'l3' 'l4' 'l5' 'l6'};

[h w] = size(param);

tokens = 300;   %divisible by 3
sims = 100;     %number of times to iterate lexical construction

allrems = zeros(sims,w); %preallocate arrays
allccms = zeros(sims,w);
allremstds = zeros(sims,w);
allccmstds = zeros(sims,w);

for sim=1:sims
   
for i=1:length(param)
    cd params;
    run(param{i});
    cd ..;
    datacell{i} = complex_lexicon(tokens,a,b,c,d,e,f);
    clear a b c d e f;
end

%number of stimuli types (wordtype-speaker pairs)
types = length(datacell);

%number of simulations
simN = factorial(types);

%preallocate arrays
remstds = zeros(simN,types);
ccmstds = zeros(simN,types);
rems = zeros(simN,types);
ccms = zeros(simN,types);

%errthang
alls = perms(datacell);

%main loop
for count=1:simN
    permd=alls(count,1:types);
    cumulator=[]; %empty starting cumulator array
    for lexicon=1:types 
        for place=1:lexicon
            cumulator=cat(2,cumulator,cell2mat(permd(place))); 
        end;
        summed=sum(cumulator,2);
        [h w]=size(cumulator);
        avg=summed/w;
        avgREM=avg(1,:); 
        avgCCM=avg(2,:);
        stdREM=std(cumulator(1,:));
        stdCCM=std(cumulator(2,:));
        if w>5
            rsdREM=stdREM/avgREM;
            rsdCCM=stdCCM/avgCCM;
        else
            rsdREM=(1+1/(4*w))*(stdREM/avgREM);
            rsdCCM=(1+1/(4*w))*(stdCCM/avgCCM);
        end
        rems(count,lexicon)=rsdREM;
        ccms(count,lexicon)=rsdCCM;
        remstds(count,lexicon)=stdREM;
        ccmstds(count,lexicon)=stdCCM;
        cumulator=[]; %resets cumulator
    end;
end; %end main loop

%averaging sims
allremstds(sim,:) = sum(remstds,1)/simN;
allccmstds(sim,:) = sum(ccmstds,1)/simN;
allrems(sim,:) = sum(rems,1)/simN;
allccms(sim,:) = sum(ccms,1)/simN;

end

remarray=mean(allrems);
ccmarray=mean(allccms);
remstdarray=mean(allremstds);

x=remstdarray;

plot(x,remarray,'r-',x,ccmarray,'k--');
%lsline;