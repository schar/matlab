function f = bal(datacell)

[h,w]=size(datacell);
x=cell(h,w);

for i=1:w
    
    cv=datacell{1,i};
    ccv=datacell{2,i};
    
    [~,w1]=size(cv);
    [~,w2]=size(ccv);
    
    if isequal(w1,w2)
        x{1,i}=cv;
        x{2,i}=ccv;
        
    else
        if w1<w2
            permdccv=ccv(:,randperm(w2));
            choppedccv=permdccv(:,1:w1);
            x{1,i}=cv;
            x{2,i}=choppedccv;
            
        else
            permdcv=cv(:,randperm(w1));
            choppedcv=permdcv(:,1:w2);
            x{1,i}=choppedcv;
            x{2,i}=ccv;
        end
    end
end

y=cell(1,w);

for i=1:w
    y{i}=[x{1,i} x{2,i}];
end

f=y;