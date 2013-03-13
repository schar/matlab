close all; clear all;   
randn('state',0); %reset the random number generator

%load data (dataset must define 'datacell')
run('data');

%number of stimuli types (wordtype-speaker pairs)
types = length(datacell);

%preallocate arrays
rems = zeros(types,1);
ccms = zeros(types,1);
stds = zeros(types,1);

%main loop
for count=1:types
    triad = cell2mat(datacell(count));
    summed = sum(triad,2);
    avg = summed/length(triad);
    avgrem = avg(1);
    avgccm = avg(2);
    stdrem = std(triad(1,1:length(triad)));
    stdccm = std(triad(2,1:length(triad)));
    rsdrem = stdrem/avgrem;
    rsdccm = stdccm/avgccm;
    stds(count,1) = stdrem;
    rems(count,1) = rsdrem;
    ccms(count,1) = rsdccm;
end; %end main loop

%scatter(stds,rems);
x=stds;
plot(x, rems, 'b*', x, ccms, 'k.');
axis([0 40 0 .30001])
lsline;

corrrem = corr(stds,rems);
corrccm = corr(stds,ccms);