remarray = [0.1281	0.2124	0.2444	0.2606	0.2702	0.2763	0.2805	0.2836	0.2858];
ccmarray = [0.1752	0.2254	0.2452	0.2554	0.2614	0.2653	0.2680	0.2699	0.2714];
stdarray = [19.3243 33.2272 38.1292 40.5500 41.9715 42.8918 43.5273 43.9879 44.3347];
both = [remarray ; ccmarray];

%h1l = line(1:9, remarray, 'Color', 'r');
%h2l = line(1:9, ccmarray, 'Color', 'k');

%ax1 = gca;
%set(ax1,'XColor','k','YColor','k')

%ax2 = axes('Position',get(ax1,'Position'),...
%           'XAxisLocation','top',...
%           'YAxisLocation','right',...
%           'Color','none',...
%           'XColor','b','YColor','b');

%h3l = line(1:9, stdarray, 'Color', 'b', 'Parent', ax2);

plot(stdarray,remarray,'r-', stdarray,ccmarray,'k--');
%lsline;
%38.452ms ~ 1478.556ms^2 crossover