function g = complex_lexicon(tokens,a,b,c,d,e,f)

N = tokens;         %number of datapoints; divisible by 3

CC = zeros(1,N) + 500; % generate N Gaussian distributed numbers with mean 500, variance 0

%CV
C11 = zeros(1,N/3); %left edge of C3
C12 = zeros(1,N/3); %right edge of C3
CC1 = zeros(1,N/3); %right edge of C3

for n=1:N/3;
    noise = sqrt(d^2/4) * randn; % normally distributed random error, 0 mean
    C11(n) = CC(n) - a/2 + noise;
    C12(n) = CC(n) - a/2 + noise; % generate L3 corresponding to R3
end;

% calculate midpoint of prevocalic consonant
for n=1:N/3;
    CC1(n) = (C11(n) + C12(n))/2;
end;

%CCV    
C21 = zeros(1,N/3); 
C22 = zeros(1,N/3); 
C23 = zeros(1,N/3); 
C24 = zeros(1,N/3); 
CC2 = zeros(1,N/3); 

               
% for CC/CCC tokens 
for n=1:N/3; 
    noise = sqrt(d^2 + e^2/4)*randn; 
    C21(n) = CC(n) - a - b/2 + noise;
    C24(n) = CC(n) + a + b/2 + noise;
end; 
%
for n=1:N/3;
    noise = sqrt(e^2/4)*randn; 
    C22(n) = CC(n) - b/2 + noise; 
    C23(n) = CC(n) + b/2 + noise;
end;
%            
for n=1:N/3;
    CC2(n) = (C21(n) + C22(n) + C23(n) + C24(n))/4; %
end;   

%CCCV            
C31 = zeros(1,N/3); 
C32 = zeros(1,N/3); 
C33 = zeros(1,N/3);
C34 = zeros(1,N/3);
C35 = zeros(1,N/3);
C36 = zeros(1,N/3);
CC3 = zeros(1,N/3);

% for CCC tokens 
for n=1:(N/3);
    noise = sqrt(9/4*d^2 + e^2)*randn; 
    C31(n) = CC(n) - 3/2*a - b + noise; 
    C36(n) = CC(n) + 3/2*a + b + noise; 
end;

for n=1:(N/3);
    noise = sqrt(d^2/4 + e^2)*randn; 
    C32(n) = CC(n) - a/2 - b + noise; 
    C35(n) = CC(n) + a/2 + b + noise; 
end;

for n=1:(N/3);
    noise = sqrt(d^2/4)*randn; 
    C33(n) = CC(n) - a/2 + noise; 
    C34(n) = CC(n) + a/2 + noise; 
end;


for n=1:N/3;
    CC3(n) = (C31(n) + C32(n) + C33(n) + C34(n) + C35(n) + C36(n))/6; %
end;  
    

        
% generate timestamps for CCGlobal 
% preallocate array for efficiency
CCglobal = [CC1 CC2 CC3];
REglobal = [C12 C24 C36];

% generate anchor points              
% preallocate array for efficiency
A = zeros(1,N); 

%cycle loop produces new anchor for each token
for m=1:N; %creates anchor point for each token from the right edge of the token
    e = f * randn; % normally distributed random error, assuming mean of 0
    A(m) = CC(m) + c + e;  % generate anchor A corresponding to CR3
end;

rem=A-REglobal;
ccm=A-CCglobal;

g=[rem;ccm];