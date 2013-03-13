close all; clear all;
%randn('state',0);   %reset the random number generator

simN = 3000;        %number of times simulation is repeated
anchors = 200;

RE_RSD=zeros(simN,anchors);
CC_RSD=zeros(simN,anchors);

for count=1:simN
    
for anchorstd=1:anchors
    
     intervals = complex_lexicon(9999,30,40,267,20,20,anchorstd-1);
     rems = intervals(1,:);
     ccms = intervals(2,:);
     
     RE_RSD(count,anchorstd) = std(rems)/mean(rems);
     CC_RSD(count,anchorstd) = std(ccms)/mean(ccms);
     
end    

end
     
x = 1:anchors; %establishes x-axis as anchor
plot(x, mean(RE_RSD(:,x)), 'r-',x, mean(CC_RSD(:,x)), 'k--');