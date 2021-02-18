function [tittle] = parcleMotn(NS, EW, Zee, pArriv, sArriv, sampRate, ranj1, ranj2)
% Particle motion diagrams - plot of components against one another
% run figure04.m first to access trace data
% last updated aamatya 1/15/2021
tims = (1:length(NS)) ./ sampRate;
pStart = ceil(pArriv) * sampRate;
pEnd = pStart + ranj1; %floor(sArriv) * sampRate - 10000;
sStart = ceil(sArriv) * sampRate;
sEnd = sStart + ranj2;


% P-wave in R-Z
subplot(2,2,1);
hold on
plot(NS(pStart:pEnd), Zee(pStart:pEnd),'Color', [.3 .3 .3]);
% scatter(NSpts, Zeepts, 5, linspace(0,1,length(NSpts)),'filled')
% colormap(copper); colorbar;
xlabel('R [South (-) North (+)]'); %EW [West (-) East (+)]');
ylabel('Z [Down (-) Up (+)]');
box on
% xlim([-6e4 6e4]); %make universal
% ylim([-6e4 6e4]);
axis equal
title('P Wave in R-Z');
for i = 1:10
    ids = linspace(pStart, pEnd, 10);
    text(NS(floor(ids(i))), Zee(floor(ids(i))), sprintf('%d', i));
end

hold off
% p-wave in T-R
subplot(2,2,2);
plot(EW(pStart:pEnd), NS(pStart:pEnd),'Color',[.7 .7 .7]);
% scatter(EWpts, NSpts, 5, linspace(0,1,length(NSpts)),'filled')
% colormap(copper); colorbar;
xlabel('T [West (-) East (+)]');
ylabel('R [South (-) North (+)]');
box on
hold on
% xlim([-6e4 6e4]);
% ylim([-6e4 6e4]);
axis equal
title('P Wave in T-R');
for i = 1:10
    ids = linspace(pStart, pEnd, 10);
    text(EW(floor(ids(i))), NS(floor(ids(i))), sprintf('%d', i));
end
hold off
% s-wave in R-Z
subplot(2,2,3)
hold on
plot(NS(sStart:sEnd), Zee(sStart:sEnd),'Color', [.3 .3 .3]);
% scatter(NSpts, Zeepts, 5, linspace(0,1,length(NSpts)),'filled')
% colormap(copper); colorbar;
xlabel('R [South (-) North (+)]'); %EW [West (-) East (+)]');
ylabel('Zee [Down (-) Up (+)]');
% xlim([-6e4 6e4]);
% ylim([-6e4 6e4]);
axis equal
title('S Wave in R-Z');
for i = 1:10
    ids = linspace(sStart, sEnd, 10);
    text(NS(floor(ids(i))), Zee(floor(ids(i))), sprintf('%d', i));
end
hold off
tittle = sgtitle('P-Wave Particle Motion');
end

% close box grid on
