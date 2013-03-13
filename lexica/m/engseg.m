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
segregated=cell(1,howManySpeakers);

current=cropped{1,1};
i=1; %index

for n=1:h-1
    row=cropped(n,:);
    [a b]=size(row);
    name=row{1};
    if isequal(name,current)
        segregated{i}=[segregated{i}; row{:,4:b}];
    else
        i=i+1;
        current=name;
        segregated{i}=[segregated{i}; row{:,4:b}];
    end;
end;

clear a b current h i intervals n name row speakers w;

                            %transpose
for n=1:howManySpeakers
    segregated{n}=segregated{n}';
end;

clear howManySpeakers n uniqs xrmb;

datacell=segregated;
clear segregated;

%save('xspeaker.mat');