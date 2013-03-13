function g = simplex_lexicon(tokens,a,b,c,d,e,f)

N = tokens;         %number of datapoints; divisible by 3

% generate timestamps for C3 (the prevocalic consonant)
% preallocate arrays for efficiency
CL3 = zeros(1,N); %left edge of C3
CM3 = zeros(1,N); %right edge of C3
CR3 = zeros(1,N); %right edge of C3

% generate R(ight plateau edge = Release) of prevocalic consonant
CR3 = 0.*randn(1,N) + 500; % generate N Gaussian distributed numbers with mean 500, variance 0

% generate L(eft plateau edge = Target) of prevocalic consonant 
for n=1:N;
    noise = d * randn; % normally distributed random error, 0 mean
    CL3(n) = CR3(n) - a + noise; % generate L3 corresponding to R3
end;

% calculate midpoint of prevocalic consonant
for n=1:N;
    CM3(n) = (CR3(n) + CL3(n))/2;
end;
        
% generate timestamps for C2 
CL2 = zeros(1,(2*(N/3))); %left edge of C2
CM2 = zeros(1,(2*(N/3))); %right edge of C2
CR2 = zeros(1,(2*(N/3))); %right edge of C2
               
% for CC/CCC tokens 
for n=1:(2*(N/3)); 
    noise = sqrt(d^2 + e^2)*randn; 
    CR2(n) = CR3(n) - a - b + noise; 
end; 
%
for n=1:(2*(N/3));
    noise = sqrt(4*d^2 + e^2)*randn; 
    CL2(n) = CR3(n) - 2*a - b + noise; 
end;
%            
for n=1:(2*(N/3));
    CM2(n) = (CR2(n) + CL2(n))/2; %
end;   

            
% generate timestamps for C1 
% preallocate arrays for efficiency
CL1 = zeros(1,(N/3)); %left edge of C1
CM1 = zeros(1,(N/3)); %right edge of C1
CR1 = zeros(1,(N/3)); %right edge of C1

% for CCC tokens 
for n=1:(N/3);
    noise = sqrt(4*d^2 + 4*e^2)*randn; 
    CR1(n) = CR3(n) - 2*a - 2*b + noise; 
end;

% generate L(eft plateau edge = Target) of C1 
% for CCC tokens 
for n=1:(N/3);
    noise = sqrt(9*d^2 + 4*e^2)*randn; 
    CL1(n) = CR3(n) - 3*a - 2*b + noise;  
end;
% for CC tokens 
for k=n+1:n+(N/3);
    CL1(k) = CL2(k);   
end;
% for C tokens 
for j=k+1:k+(N/3);
    CL1(j) = CL3(j); 
end;

% calculate midpoint of C1 (for CCC only)
for n=1:N/3;
    CM1(n) = (CR1(n) + CL1(n))/2; %
end;  
    

        
% generate timestamps for CCGlobal 
% preallocate array for efficiency
CCglobal = zeros(1,N); %mean of midpoints

%for CCC clusters
for n=1:(N/3);
    CCglobal(n) = 1/3 * (CM1(n) + CM2(n) + CM3(n)); % mean of consonant midpoints  
end;

%for CC clusters
for k=n+1:n+(N/3);
    CCglobal(k) = 1/2 * (CM2(k) + CM3(k)); % mean of consonant midpoints  
end;

%for C clusters
for j=k+1:k+(N/3);
    CCglobal(j) = CM3(j); % CCglobal synchronous with prevocalic midpoint
end;     

% generate anchor points              
% preallocate array for efficiency
A = zeros(1,N); 

%cycle loop produces new anchor for each token
for m=1:N; %creates anchor point for each token from the right edge of the token
    e = f * randn; % normally distributed random error, assuming mean of 0
    A(m) = CR3(m) + c + e;  % generate anchor A corresponding to CR3
end;

rem=A-CR3;
ccm=A-CCglobal;

g=[rem;ccm];