clear all;

cd csv;

csvimport('xabac.csv');  %importing data from .csv file
xrmb=ans;
[h w]=size(xrmb);
cropped=xrmb(2:h,2:w);      %cropping the cell array
speakers=cropped(:,1);      %vector of speaker occurrences
uniqs=unique(speakers);     %vector of the unique speakers
howManySpeakers=length(uniqs);  %47
clear ans;
cd ..;

                            %segregating algorithm
segregated=cell(2,howManySpeakers);

current=cropped{1,1};
i=1; %index

for n=1:h-1
    row=cropped(n,:);
    [a b]=size(row);
    name=row{1};
    onset=row{3};
    if isequal(name,current)
        if isequal(onset,'C')
            segregated{1,i}=[segregated{1,i}; row{:,4:b}];
        else
            segregated{2,i}=[segregated{2,i}; row{:,4:b}];
        end;
    else
        i=i+1;
        current=name;
        if isequal(onset,'C')
            segregated{1,i}=[segregated{1,i}; row{:,4:b}];
        else
            segregated{2,i}=[segregated{2,i}; row{:,4:b}];
        end;
    end;
end;

clear a b current h i intervals n name onset row speakers w;

                            %transpose
[h w]=size(segregated);
dims=h*w;

for n=1:dims
    segregated{n}=segregated{n}';
end;

clear howManySpeakers n uniqs xrmb;

datacell=segregated;
clear dims h segregated w;

%save('xspeaker.mat');