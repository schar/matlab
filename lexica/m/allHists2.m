clear all; 

load('workspace');
diffs=rems-ccms;
n=length(diffs(1,:));

if ~exist('hists', 'dir')
    mkdir('hists')
end;

cd hists;

if ~exist('figs', 'dir')
    mkdir('figs')
end;

if ~exist('pdfs', 'dir')
    mkdir('pdfs')
end;

for step=1:n
    column=rems(:,step);
    hist(column);
    h = findobj(gca,'Type','patch');
    set(h,'FaceColor','m','EdgeColor','k');
    figuresize(8,6,'inches');
    cd figs;
    saveas(gcf, ['rem' num2str(step) '.fig']);
    cd ..;
    cd pdfs;
    saveas(gcf, ['rem' num2str(step) '.pdf']);
    cd ..;
end;

for step=1:n
    column=ccms(:,step);
    hist(column);
    h = findobj(gca,'Type','patch');
    set(h,'FaceColor','r','EdgeColor','k');
    figuresize(8,6,'inches');
    cd figs;
    saveas(gcf, ['ccm' num2str(step) '.fig']);
    cd ..;
    cd pdfs;
    saveas(gcf, ['ccm' num2str(step) '.pdf']);
    cd ..;
end;

for step=1:n
    column=diffs(:,step);
    hist(column);
    h = findobj(gca,'Type','patch');
    set(h,'FaceColor','c','EdgeColor','k');
    figuresize(8,6,'inches');
    cd figs;
    saveas(gcf, ['diff' num2str(step) '.fig']);
    cd ..;
    cd pdfs;
    saveas(gcf, ['diff' num2str(step) '.pdf']);
    cd ..;
end;

cd ..;

clear all;