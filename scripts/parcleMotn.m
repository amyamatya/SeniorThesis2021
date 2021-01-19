function [tittle] = parcleMotn(NS, EW, Zee, pArriv, sArriv, sampRate)
% Particle motion diagrams - plot of components against one another
% run figure04.m first to access trace data
% last updated aamatya 1/15/2021
tims = (1:length(NS)) ./ sampRate;
pStart = ceil(pArriv) * sampRate;
pEnd = pStart + 600; %floor(sArriv) * sampRate - 10000;
sStart = ceil(sArriv) * sampRate;
sEnd = sStart + 600;
% P-wave in NS-Z
subplot(2,2,1);
hold on
plot(NS(pStart:pEnd), Zee(pStart:pEnd),'Color', [.3 .3 .3]);
% scatter(NSpts, Zeepts, 5, linspace(0,1,length(NSpts)),'filled')
% colormap(copper); colorbar;
xlabel('NS [South (-) North (+)]'); %EW [West (-) East (+)]');
ylabel('Zee [Down (-) Up (+)]');
box on
axis tight
title('P Wave in NS-Z');
for i = 1:10
    ids = linspace(pStart, pEnd, 10);
    text(NS(floor(ids(i))), Zee(floor(ids(i))), sprintf('%d', i));
end
hold off
% p-wave in EW-NS
subplot(2,2,2);
plot(EW(pStart:pEnd), NS(pStart:pEnd),'Color',[.7 .7 .7]);
% scatter(EWpts, NSpts, 5, linspace(0,1,length(NSpts)),'filled')
% colormap(copper); colorbar;
xlabel('EW [West (-) East (+)]');
ylabel('NS [South (-) North (+)]');
box on
hold on
axis tight
title('P Wave in EW-NS');
for i = 1:10
    ids = linspace(pStart, pEnd, 10);
    text(EW(floor(ids(i))), NS(floor(ids(i))), sprintf('%d', i));
end
hold off
% s-wave in NS-Z
subplot(2,2,3)
hold on
plot(NS(sStart:sEnd), Zee(sStart:sEnd),'Color', [.3 .3 .3]);
% scatter(NSpts, Zeepts, 5, linspace(0,1,length(NSpts)),'filled')
% colormap(copper); colorbar;
xlabel('NS [South (-) North (+)]'); %EW [West (-) East (+)]');
ylabel('Zee [Down (-) Up (+)]');
axis tight
title('S Wave in NS-Z');
for i = 1:10
    ids = linspace(sStart, sEnd, 10);
    text(NS(floor(ids(i))), Zee(floor(ids(i))), sprintf('%d', i));
end
hold off
tittle = sgtitle('P-Wave Particle Motion');
end

