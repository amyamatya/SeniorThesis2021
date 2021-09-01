function [title] = parcleZoom(startTime, endTime, rad, trans, vert, PArriv, SArriv, pPeriod, sPeriod, title)
% Wave arrival zoom diagrams for particle motion plots
% last updated @aamatya 4/6/21
%---------Input Variables------------------------------------
% startTime, endTime           - event time ('YYYY-MM-DD H:M:S')
% rad, trans, vert             - component data (1*n matrix)
% PArriv, SArriv               - predicted arrivals
% pPeriod, sPeriod             - wave durations (s)
% title                        - title string
%-----------------------------------------------------------
startTime = datestr(startTime,'yyyy-mm-ddTHH:MM:SS');
endTime = datestr(endTime,'yyyy-mm-ddTHH:MM:SS');
elapTime = eIristime(startTime, endTime);
tims = linspace(0, elapTime, length(rad));
xConvert = length(tims)/elapTime;
pStartId = [floor(PArriv*xConvert) floor((PArriv+pPeriod)*xConvert)];
sStartId = [floor(SArriv*xConvert) floor((SArriv+sPeriod)*xConvert)];
wholeRad = [rad(pStartId(1):sStartId(2)) rad(pStartId(1):sStartId(2))];
wholeTrans = [trans(pStartId(1):sStartId(2)) trans(pStartId(1):sStartId(2))];
wholeVert = [vert(pStartId(1):sStartId(2)) vert(pStartId(1):sStartId(2))];
yMin = min(min([wholeRad wholeTrans wholeVert]));
yMax = max(max([wholeRad wholeTrans wholeVert]));
clf

subplot(3,1,1)
ylabel('Radial');
xticks([]);
hold on
box on
fill([tims(pStartId(1)) tims(pStartId(2)) tims(pStartId(2)) tims(pStartId(1))],...
    [-1e10 -1e10 1e10 1e10],'r','facealpha',0.1);
fill([tims(sStartId(1)) tims(sStartId(2)) tims(sStartId(2)) tims(sStartId(1))],...
    [-1e10 -1e10 1e10 1e10],'r','facealpha',0.1);
plot(tims, rad,'Color', rgb('LightSteelBlue'));
plot(tims(pStartId(1):pStartId(2)), rad(pStartId(1):pStartId(2)), 'color',rgb('SteelBlue'),'linewidth',.7);
plot(tims(sStartId(1):sStartId(2)), rad(sStartId(1):sStartId(2)), 'color',rgb('SteelBlue'),'linewidth',.7);
set(gca, 'xticklabels',[]);
set(gca, 'linewidth',1.5);
xlim([tims(pStartId(1)-(30*xConvert)) tims(sStartId(2)+(30*xConvert))])
ylim([yMin yMax]);
ax = gca;
axes('Position',[ax.Position(1)+0.17 ax.Position(2)+0.03 ax.Position(3)/9 ax.Position(4)/1.4]);
plot(tims(pStartId(1):pStartId(2)), rad(pStartId(1):pStartId(2)), 'r','linewidth',.8);
yticks([min(rad(pStartId(1):pStartId(2))) 0 max(rad(pStartId(1):pStartId(2)))]);
xticks([tims(pStartId(1)) tims(pStartId(2))]);
set(gca,'xticklabel',[]);
set(gca, 'GridAlpha',0.6);
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'))
set(gca, 'YGrid','on');
axis tight
axes('Position',[ax.Position(1)+0.52 ax.Position(2)+0.03 ax.Position(3)/9 ax.Position(4)/1.4]);
plot(tims(sStartId(1):sStartId(2)), rad(sStartId(1):sStartId(2)), 'r','linewidth',.8);
yticks([min(rad(sStartId(1):sStartId(2))) 0 max(rad(sStartId(1):sStartId(2)))]);
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'))
set(gca,'xticklabel',[]);
set(gca, 'YGrid','on');
set(gca, 'GridAlpha',0.6);
axis tight
hold off


subplot(3,1,2)
ylabel('Transverse');
xticks([]);
hold on
box on
fill([tims(pStartId(1)) tims(pStartId(2)) tims(pStartId(2)) tims(pStartId(1))],...
    [-1e10 -1e10 1e10 1e10],'r','facealpha',0.1);
fill([tims(sStartId(1)) tims(sStartId(2)) tims(sStartId(2)) tims(sStartId(1))],...
    [-1e10 -1e10 1e10 1e10],'r','facealpha',0.1);
plot(tims, trans,'Color', rgb('LightSteelBlue'));
plot(tims(pStartId(1):pStartId(2)), trans(pStartId(1):pStartId(2)), 'color',rgb('SteelBlue'),'linewidth',.7);
plot(tims(sStartId(1):sStartId(2)), trans(sStartId(1):sStartId(2)), 'color',rgb('SteelBlue'),'linewidth',.7);
set(gca, 'xticklabels',[]);
set(gca, 'linewidth',1.5);
xlim([tims(pStartId(1)-(30*xConvert)) tims(sStartId(2)+(30*xConvert))])
ylim([min(trans(pStartId(1):sStartId(2))) max(trans(pStartId(1):sStartId(2)))]);
ylim([yMin yMax]);
ax = gca;
axes('Position',[ax.Position(1)+0.17 ax.Position(2)+0.03 ax.Position(3)/9 ax.Position(4)/1.4]);
plot(tims(pStartId(1):pStartId(2)), trans(pStartId(1):pStartId(2)), 'r','linewidth',.8);
set(gca,'xticklabel',[]);
yticks([min(trans(pStartId(1):pStartId(2))) 0 max(trans(pStartId(1):pStartId(2)))]);
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'))
set(gca, 'YGrid','on');
set(gca, 'GridAlpha',0.6);
axis tight
axes('Position',[ax.Position(1)+0.52 ax.Position(2)+0.03 ax.Position(3)/9 ax.Position(4)/1.4]);
plot(tims(sStartId(1):sStartId(2)), trans(sStartId(1):sStartId(2)), 'r','linewidth',.8);
set(gca,'xticklabel',[]);
yticks([min(trans(sStartId(1):sStartId(2))) 0 max(trans(sStartId(1):sStartId(2)))]);
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'))
set(gca, 'YGrid','on');
set(gca, 'GridAlpha',0.6);
axis tight
hold off


subplot(3,1,3)
xlabel('Time Since First P-Arrival (s)');
ylabel('Vertical');
xticks([PArriv SArriv]);
xticklabels([0 round(SArriv-PArriv)]);
hold on
box on
ax = gca;
fill([tims(pStartId(1)) tims(pStartId(2)) tims(pStartId(2)) tims(pStartId(1))],...
    [-1e10 -1e10 1e10 1e10],'r','facealpha',0.1);
fill([tims(sStartId(1)) tims(sStartId(2)) tims(sStartId(2)) tims(sStartId(1))],...
    [-1e10 -1e10 1e10 1e10],'r','facealpha',0.1);
plot(tims, vert,'Color', rgb('LightSteelBlue'));
plot(tims(pStartId(1):pStartId(2)), vert(pStartId(1):pStartId(2)), 'color',rgb('SteelBlue'),'linewidth',1.4);
plot(tims(sStartId(1):sStartId(2)), vert(sStartId(1):sStartId(2)), 'color',rgb('SteelBlue'),'linewidth',1.3);
set(gca, 'linewidth',1.5);
xlim([tims(pStartId(1)-(30*xConvert)) tims(sStartId(2)+(30*xConvert))])
ylim([min(vert(pStartId(1):sStartId(2))) max(vert(pStartId(1):sStartId(2)))]);
ylim([yMin yMax]);
ax = gca;
axes('Position',[ax.Position(1)+0.17 ax.Position(2)+0.03 ax.Position(3)/9 ax.Position(4)/1.4]);
plot(tims(pStartId(1):pStartId(2)), vert(pStartId(1):pStartId(2)), 'r','linewidth',1.3);
yticks([min(vert(pStartId(1):pStartId(2))) 0 max(vert(pStartId(1):pStartId(2)))]);
set(gca,'xticklabel',[]);
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'))
set(gca, 'YGrid','on');
set(gca, 'GridAlpha',0.6);
axis tight
box on
axes('Position',[ax.Position(1)+0.52 ax.Position(2)+0.03 ax.Position(3)/9 ax.Position(4)/1.4]);
plot(tims(sStartId(1):sStartId(2)), vert(sStartId(1):sStartId(2)), 'r','linewidth',1.3);
yticks([min(vert(sStartId(1):sStartId(2))) 0 max(vert(sStartId(1):sStartId(2)))]);
set(gca,'xticklabel',[]);
tix=get(gca,'ytick')';
set(gca,'yticklabel',num2str(tix,'%.f'))
set(gca, 'YGrid','on');
set(gca, 'GridAlpha',0.6);
axis tight
hold off
title = sgtitle(title);
set(gcf, 'PaperSize', [10 7]);
end