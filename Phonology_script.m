% JAS: this script simulates consonant cluster data based upon the Simplex
% Onset Hypothesis and identifies the SD of the anchor that best
% fits the data.
% Output is a graph which plots R^2, goodness of fit, statistic by anchor


close all; clear all;
randn('state',0); % Reset the random number generator

simN = 1000; %number of times simulation is repeated
for count=1:simN %loops through iterations of the simulation
    
    
    N = 30;    % number of datapoints; divisible by 3
    stdv = 20;
    p = 30; % plateau duration
    ipi = 40; % inter-plateau interval

    % generate timestamps for C3 (the prevocalic consonant)
     % preallocate arrays for efficiency
        CL3 = zeros(1,N); %left edge of C3
        CM3 = zeros(1,N); %right edge of C3
        CR3 = zeros(1,N); %right edge of C3

        % generate R(ight plateau edge = Release) of prevocalic consonant
        CR3 = sqrt(400).*randn(1,N) + 500; % generate N Gaussian distributed numbers with mean 500, variance 400

        % generate L(eft plateau edge = Target) of prevocalic consonant 
        for n=1:N;
            e = stdv * randn; % normally distributed random error, 0 mean
            CL3(n) = CR3(n) - (p + e); % generate L3 corresponding to R3 by assuming a plateau duration of 10 ms
        end;

        % calculate midpoint of prevocalic consonant
        for n=1:N;
            CM3(n) = (CR3(n) + CL3(n))/2; %
        end;

    %plot timestamps for C3
        nbins = 20;
%        [CL3h,CL3out] = hist(CL3,nbins); % returns vectors Lh and Lout containing the frequency counts and the bin locations. 
%        [CR3h,CR3out] = hist(CR3,nbins); % returns vectors Lh and Lout containing the frequency counts and the bin locations.
%        subplot(5,2,1);
%        bar(CL3out,CL3h); % plot the histogram
%        subplot(5,2,2);
%        bar(CR3out,CR3h); % plot the histogram

    % generate timestamps for C2 
        % preallocate arrays for efficiency
        CL2 = zeros(1,(2*(N/3))); %left edge of C2
        CM2 = zeros(1,(2*(N/3))); %right edge of C2
        CR2 = zeros(1,(2*(N/3))); %right edge of C2
           
        % generate R(ight plateau edge = Release) of C2 from left edge of C3
            % for C tokens 
            %for n=1:(N/3)
            %    CR2(n) = CR3(n); % the right edge of the cluster is the same as the right edge of the prevocalic consonant  
            %end;
    
            % for CC/CCC tokens 
            for n=1:(2*(N/3)); % alternative, use ceiling function
                e = stdv * randn; % normally distributed random error
                CR2(n) = CL3(n) - (ipi + e); % generate right edge of C2 from left edge of C2 assuming an ipi of 40 ms
            end; 
    
       
        % generate L(eft plateau edge = Target) of C2 
            % for C tokens 
            %for n=1:(N/3)
            %    CL2(n) = CL3(n); % the left edge of the cluster is the same as the left edge of the prevocalic consonant  
            %end;
    
            % for CC/CCC tokens 
            for n=1:(2*(N/3));
                e = stdv * randn; % normally distributed random error based on relation with CR3
                CL2(n) = CR2(n) - (p + e); % generate L2 corresponding to CR3 by assuming a plateau duration
            end;
                             
        % calculate midpoint of C2
        % C tokens have no C2 and therefore no C2 midpoint
        for n=1:(2*(N/3));
            CM2(n) = (CR2(n) + CL2(n))/2; %
        end;   

    %plot timestamps for C2    
%        [CL2h,CL2out] = hist(CL2,nbins) % returns vectors Lh and Lout containing the frequency counts and the bin locations. 
%        [CR2h,CR2out] = hist(CR2,nbins) % returns vectors Lh and Lout containing the frequency counts and the bin locations.
%        subplot(5,2,3);
%        bar(CL2out,CL2h); % plot the histogram
%        subplot(5,2,4);
%        bar(CR2out,CR2h); % plot the histogram

    % generate timestamps for C1 
        % preallocate arrays for efficiency
        CL1 = zeros(1, N); %left edge of C1
        CM1 = zeros(1,(N/3)); %right edge of C1
        CR1 = zeros(1,(N/3)); %right edge of C1
 
        % generate R(ight plateau edge = Release) of C1 
        % for C tokens 
        %    for n=1:(N/3)
        %        CR1(n) = CR2(n); % the right edge of the cluster is the same as the right edge of the prevocalic consonant  
        %    end;
    
        %    % for CC tokens 
        %    for n=(N/3):(2*(N/3))
        %       CR1(n) = CR3(n); % the right edge of C1 equals the right edge of C3
        %    end; 
    
            % for CCC tokens 
            for n=1:(N/3);
               e = stdv * randn; % normally distributed random error
                CR1(n) = CL2(n) - (ipi + e); % generate right edge of C1 from left edge of C2 assuming ipi of 40ms
            end;
        
        % generate L(eft plateau edge = Target) of C1 
        % for CCC tokens 
            for n=1:(N/3);
                e = stdv * randn; % normally distributed random error based on relation with CR3
                CL1(n) = CR1(n) - (p + e); % generate L2 corresponding to CR1 by assuming a plateau of 10ms  
            end;
        % for CC tokens 
            for k=n+1:n+(N/3);
                CL1(k) = CL2(k); % left edge of C2 is the left edge of the cluster for CC  
            end;
            % for C tokens 
            for j=k+1:k+(N/3);
                CL1(j) = CL3(j); % the left edge of the cluster is the same as the left edge of the prevocalic consonant  
            end;
        
      % calculate midpoint of prevocalic consonant
        % for CCC only 
        for n=1:N/3;
            CM1(n) = (CR1(n) + CL1(n))/2; %
        end;  
    
    %plot timestamps for C1    
%        [CL1h,CL1out] = hist(CL1,nbins) % returns vectors Lh and Lout containing the frequency counts and the bin locations. 
%        [CR1h,CR1out] = hist(CR1,nbins) % returns vectors Lh and Lout containing the frequency counts and the bin locations.
%        subplot(5,2,5);
%        bar(CL1out,CL1h); % plot the histogram
%        subplot(5,2,6);
%        bar(CR1out,CR1h); % plot the histogram

    % generate timestamps for CCGlobal 
        % preallocate array for efficiency
        CCglobal = zeros(1, N); %mean of midpoints

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
        AN = 20; %number of anchor points
        AD = 250; %interval from prevocalic consonant to closest anchor point
        DI = 0; % interval added to each subsequent anchor point
        VI = 5; % stepwise increase in variability
        
        % preallocate array for efficiency
        A = zeros(AN,N); %one column for each anchor (AN) and one row for each token
        
        %cycle loop produces new anchor for each token
        for cycle = 1: AN; %creates multiple anchor points for each token
            for m=1:N; %creates anchor point for each token from the right edge of the token
                Ae = stdv * randn; % normally distributed random error, assuming mean of 0
                A(cycle, m) = CR3(m) + AD + Ae;  % generate anchor A corresponding to CR3 by assuming a period of 200 ms
            end;
            AD = AD + DI; %increases distance for each anchor point by interval DI
            stdv = stdv + VI; %creates new anchor point  
        end; 
    
    % plot anchor points
%    [Ah,Aout] = hist(A(1,:),nbins) % returns vectors Lh and Lout containing the frequency counts and the bin locations. 
%    subplot(5,2,7);
%    bar(Aout,Ah); % plot the histogram
%    ylabel('Anchor 1');

%    [Ah,Aout] = hist(A(4,:),nbins) % returns vectors Lh and Lout containing the frequency counts and the bin locations. 
%    subplot(5,2,8);
%    bar(Aout,Ah); % plot the histogram
%    ylabel('Anchor 4');


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
        plot(x, mean(LE_RSD(:,x)), 'b-',x, mean(RE_RSD(:,x)), 'g-',x, mean(CC_RSD(:,x)), 'r:');
       
     












