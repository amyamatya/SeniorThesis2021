function [theFig] = parcleMotn(RC, TC, ZC, pArriv, sArriv, sampRate, pPeriod, sPeriod)
% Particle motion diagrams - (P-wave in R-Z, P wave in T-R, S wave in R-Z)
% last updated @aamatya 2/20/2021
%---------Input Variables------------------------------------
% RC, TC, ZC           - radial, transverse, vertical data (nx1 array)
% pArriv, sArriv        - arrival times (s)
% sampRate              - instrument sample rate
% pPeriod               - P-wave period duration (seconds)
% sPeriod               - S-wave period duration (seconds)
%-----------------------------------------------------------
pStart = ceil(pArriv) * sampRate;
pEnd = pStart + (pPeriod*sampRate);
sStart = ceil(sArriv) * sampRate;
sEnd = sStart + (sPeriod*sampRate);
pDuration = pPeriod;
sDuration = sPeriod;
% Universal axes limits
nsMin = min(min([RC(pStart:pEnd);RC(sStart:sEnd)]));
nsMax = max(max([RC(pStart:pEnd);RC(sStart:sEnd)]));
ewMin = min(min([TC(pStart:pEnd);TC(sStart:sEnd)]));
ewMax = max(max([TC(pStart:pEnd);TC(sStart:sEnd)]));
zeeMin = min(min([ZC(pStart:pEnd);ZC(sStart:sEnd)]));
zeeMax = max(max([ZC(pStart:pEnd);ZC(sStart:sEnd)]));
% P-wave in R-Z
subplot(1,3,1)
hold on
scatter(RC(pStart:pEnd), ZC(pStart:pEnd), 3, linspace(0,pDuration,length(pStart:pEnd)),'filled')
cm = brewermap(length(pStart:pEnd), 'Blues');
cm(:,1) = flip(cm(:,1)); cm(:,2) = flip(cm(:,2)); cm(:,3) = flip(cm(:,3)); 
colormap(cm);
cb = colorbar;
cb.Label.String = 'Time (s)';
set(cb, 'ticks',linspace(0, pDuration, 5));
set(cb, 'ticklabels',linspace(0, pDuration, 5));
xlabel('R [Back(-) Out (+)]'); %TC [West (-) East (+)]');
ylabel('Z [Down (-) Up (+)]');
box on
grid on
axis tight
axz = axis;
hafRanj = halverange(axz, 100);
set(gca, 'XLim', hafRanj); 
set(gca, 'YLim', hafRanj);
set(gca, 'XTick',linspace(hafRanj(1), hafRanj(2), 3));
tix=get(gca,'xtick')';
set(gca,'xticklabel',num2str(tix,'%.f'));
set(gca, 'YTick',linspace(hafRanj(1), hafRanj(2), 3));
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'));
axis square
title('P Wave in R-Z');
hold off

% p-wave in T-R
subplot(1,3,2)
scatter(RC(pStart:pEnd), TC(pStart:pEnd), 3, linspace(0,pDuration,length(pStart:pEnd)),'filled')
colormap(gray); 
cb = colorbar;
cb.Label.String = 'Time (s)';
set(cb, 'ticks',linspace(0, pDuration, 5));
set(cb, 'ticklabels',linspace(0, pDuration, 5));
ylabel('T [Left (-) Right (+)]');
xlabel('R [Back (-) Out (+)]');
axis tight
axz = axis;
hafRanj = halverange(axz, 100);
set(gca, 'XLim', hafRanj); 
set(gca, 'YLim', hafRanj);
set(gca, 'XTick',linspace(hafRanj(1), hafRanj(2), 3));
tix=get(gca,'xtick')';
set(gca,'xticklabel',num2str(tix,'%.f'));
set(gca, 'YTick',linspace(hafRanj(1), hafRanj(2), 3));
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'));
axis square
box on
grid on
title('P Wave in R-T');
hold off


% s-wave in T-R
subplot(1,3,3)
hold on
scatter(RC(sStart:sEnd), TC(sStart:sEnd), 3,linspace(0,sDuration,length(sStart:sEnd)),'filled');
cm = brewermap(length(sStart:sEnd), 'Blues');
cm(:,1) = flip(cm(:,1)); cm(:,2) = flip(cm(:,2)); cm(:,3) = flip(cm(:,3)); 
colormap(cm);
cb = colorbar;
cb.Label.String = 'Time (s)';
set(cb, 'ticks',linspace(0, sDuration, 5));
set(cb, 'ticklabels',linspace(0, sDuration, 5));
ylabel('T [Left (-) Right (+)]');
xlabel('R [Back (-) Out (+)]'); 
axis tight
axz = axis;
hafRanj = halverange(axz, 100);
set(gca, 'XLim', hafRanj); 
set(gca, 'YLim', hafRanj);
set(gca, 'XTick',linspace(hafRanj(1), hafRanj(2), 3));
tix=get(gca,'xtick')';
set(gca,'xticklabel',num2str(tix,'%.f'));
set(gca, 'YTick',linspace(hafRanj(1), hafRanj(2), 3));
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'));
axis square
box on
grid on
title('S Wave in R-T');
hold off
% tittle = sgtitle('Particle Motion');
% Label 1 through 10 time-ascending order
% for i = 1:10
%     ids = linspace(sStart, sEnd, 10);
%     text(RC(floor(ids(i))), ZC(floor(ids(i))), sprintf('%d', i));
% end
% subplot(1,2,1)
% scatter3(TC(pStart:pEnd), RC(pStart:pEnd), ZC(pStart:pEnd),5,linspace(0,pDuration, length(pStart:pEnd)),'filled')
% xlabel('T');ylabel('R');zlabel('Z');
% subplot(1,2,2)
% scatter3(TC(sStart:sEnd), RC(sStart:sEnd), ZC(sStart:sEnd),5,linspace(0,sDuration, length(sStart:sEnd)),'filled')
% xlabel('T');ylabel('R');zlabel('Z');
% cm = brewermap(length(pStart:pEnd), 'Blues');
% cm(:,1) = flip(cm(:,1)); cm(:,2) = flip(cm(:,2)); cm(:,3) = flip(cm(:,3)); 
% colormap(cm);
% cb = colorbar;
% cb.Label.String = 'Time (s)';
set(gcf, 'PaperSize', [15 7]);
theFig = gcf;

end