% JAS: this script simulates consonant cluster data based upon the Simplex
% Onset Hypothesis and identifies the SD of the anchor that best
% fits the data.
% Trivial modifications by SEC.

close all; clear all;
randn('state',0);   %reset the random number generator

simN = 100;         %number of times simulation is repeated
lexica = 9;         %number of lexica

LE_RSD = zeros(simN,AN);
RE_RSD = zeros(simN,AN);
CC_RSD = zeros(simN,AN);
LE_SD  = zeros(simN,AN);
RE_SD  = zeros(simN,AN);
CC_SD  = zeros(simN,AN);

VI = 1;         %stepwise increase in variability

stdv1 = 10;
p = 20;         %plateau duration
ipi = 10;       %inter-plateau interval
anchor = 234.8
anchorstd = 30;



for count=1:simN %loops through iterations of the simulation

    
%Note about consonantal landmarks: they are replaced with each cycle of the simulation
%in constrast, {RSD,SD} values for each landmark are stored across simulations.

        for cycle = 1:AN; %cycles through for each anchor point                
                LE_RSD(count, cycle) = std(A(cycle,:)-CL1)/(mean(A(cycle,:))-mean(CL1));
                RE_RSD(count, cycle) = std(A(cycle,:)-CR3)/(mean(A(cycle,:))-mean(CR3));
                CC_RSD(count, cycle) = std(A(cycle,:)-CCglobal)/(mean(A(cycle,:))-mean(CCglobal));
                
                LE_SD(count, cycle) = std(A(cycle,:)-CL1);
                RE_SD(count, cycle) = std(A(cycle,:)-CR3);
                CC_SD(count, cycle) = std(A(cycle,:)-CCglobal);
        end;        
 
     end %main simulation loop
     
        
     x = 1:1:AN; %establishes x-axis as anchor
     plot(x, mean(RE_RSD(:,x)), 'r-',x, mean(CC_RSD(:,x)), 'k--');
    