close all; clear all;   
randn('state',0); %reset the random number generator

%load data (dataset must define 'datacell')
run('data2');

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
remstdarray = sum(remstds,1)/simN;
ccmstdarray = sum(ccmstds,1)/simN;
remarray = sum(rems,1)/simN;
ccmarray = sum(ccms,1)/simN;

%values
%rems    0.1280    0.2123    0.2445    0.2608    0.2704    0.2766    0.2808    0.2839    0.2861
%ccms    0.1752    0.2254    0.2452    0.2554    0.2614    0.2653    0.2680    0.2699    0.2714
%remstds 19.2877   33.2014   38.1137   40.5432   41.9708   42.8950   43.5330   43.9951   44.3429
%ccmstds 38.2646   50.6320   55.0958   57.3375   58.6595   59.5187   60.1166   60.5551   60.8905

%graph
x=remstdarray;
plot(x, remarray, 'ro', x, ccmarray, 'ks');
lsline;

%histogram
%diffs = rems - ccms;
%hist(diffs);