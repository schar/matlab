% JAS: this script simulates consonant cluster data based upon the Simplex
% Onset Hypothesis and identifies the SD of the anchor that best
% fits the data.
% Trivial modifications by SEC.


close all; clear all;
randn('state',0);   %reset the random number generator

simN = 3000;        %number of times simulation is repeated
lexica = 9;         %number of lexica

for count=1:simN %loops through iterations of the simulation
    
    N = 9999;       % number of datapoints; divisible by 3
    stdv = 1;
    stdv1 = 10;
    p = 20;         % plateau duration
    ipi = 10;       % inter-plateau interval

    % generate timestamps for C3 (the prevocalic consonant)
     % preallocate arrays for efficiency
        CL3 = zeros(1,N); %left edge of C3
        CM3 = zeros(1,N); %right edge of C3
        CR3 = zeros(1,N); %right edge of C3

        % generate R(ight plateau edge = Release) of prevocalic consonant
        CR3 = 0.*randn(1,N) + 500; % generate N Gaussian distributed numbers with mean 500, variance 0

        % generate L(eft plateau edge = Target) of prevocalic consonant 
        for n=1:N;
            e = stdv1 * randn; % normally distributed random error, 0 mean
            CL3(n) = CR3(n) - p + e; % generate L3 corresponding to R3
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
                e = stdv1 * randn; 
                CR2(n) = CR3(n) - p - ipi + sqrt(2*stdv1^2)*randn; 
            end; 
            %
            for n=1:(2*(N/3));
                e = stdv1 * randn; 
                CL2(n) = CR3(n) - 2*p - ipi + sqrt(5*stdv1^2)*randn; 
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
               e = stdv1 * randn; 
                CR1(n) = CR3(n) - 2*p - 2*ipi + sqrt(8*stdv1^2)*randn; 
            end;
        
        % generate L(eft plateau edge = Target) of C1 
        % for CCC tokens 
            for n=1:(N/3);
                e = stdv1 * randn; 
                CL1(n) = CR3(n) - 3*p - 2*ipi + sqrt(13*stdv1^2)*randn;  
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
      
        
        
        
    % generate series of anchor points increasing in distance from the prevocalic consonant      
        AN = 60; %number of anchor points
        AD = 234.8; %interval from prevocalic consonant to closest anchor point
        DI = 0; % interval added to each subsequent anchor point
        VI = 1; % stepwise increase in variability
        
        % preallocate array for efficiency
        A = zeros(AN,N); %one column for each anchor (AN) and one row for each token
        
        
        %cycle loop produces new anchor for each token
        for cycle = 1:AN; %creates multiple anchor points for each token
            for m=1:N; %creates anchor point for each token from the right edge of the token
                Ae = stdv * randn; % normally distributed random error, assuming mean of 0
                A(cycle, m) = CR3(m) + AD + Ae;  % generate anchor A corresponding to CR3
            end;
            AD = AD + DI; %increases distance for each anchor point by interval DI
            stdv = stdv + VI; %creates new anchor point  
        end; 
    
%Note about consonantal landmarks: they are replaced with each cycle of the simulation
%in constrast, RSD values for each landmark are stored across simulations.

        for cycle = 1: AN; %cycles through for each anchor point
            %if CoV==0 % if 1, then coefficient of variance; if 0, standard deviation
             
                %xv = [std(A(cycle)-CL1) std(A(cycle)-CCglobal)  std(A(cycle)-CR3)];
            %else
                %xd(1, cycle) = [(mean(A(cycle,:)))]; %xd = average distance of prevocalic consonant to a given anchor 
                
                LE_RSD(count, cycle) = std(A(cycle,:)-CL1)/(mean(A(cycle,:))-mean(CL1));
                RE_RSD(count, cycle) = std(A(cycle,:)-CR3)/(mean(A(cycle,:))-mean(CR3));
                CC_RSD(count, cycle) = std(A(cycle,:)-CCglobal)/(mean(A(cycle,:))-mean(CCglobal));
                
                LE_SD(count, cycle) = std(A(cycle,:)-CL1);
                RE_SD(count, cycle) = std(A(cycle,:)-CR3);
                CC_SD(count, cycle) = std(A(cycle,:)-CCglobal);
                              
            %end;      
           
        end;        
 
     end %main simulation loop   

%Plot RSD across simulations
    % plot mean RSD across simulations as a function of anchor distance
     %   subplot(5,2,10);
     %       plot(xd, LE_RSD, 'b-', xd, RE_RSD, 'g-', xd, CC_RSD, 'r:')
    
     % plot mean RSD across simulations for each anchor point as a function of anchor number
     
        x = 1:1:AN; %establishes x-axis as anchor
        plot(x, mean(RE_RSD(:,x)), 'r-',x, mean(CC_RSD(:,x)), 'k--');
    