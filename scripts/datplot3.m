function [tittle] = datplot3(eventCords, depth, parallel, orthogonal, vertical,rotation, startT, endT, magnitude, parAzimuth, orthAzimuth, pArriv, sArriv)
% Given data, plot 3-component seismogram
% last edit  1/26/20 aamatya
% find y limits
sacvStaCords = [14.97 -23.608];
yMin = min(min([parallel; orthogonal; vertical]));
yMax = max(max([parallel ;orthogonal; vertical]));
tims = 1:length(parallel);
% calculate trace duration, distance, depths
t1 = datevec(startT,'yyyy-mm-dd HH:MM:SS');
t2 = datevec(endT,'yyyy-mm-dd HH:MM:SS');
elapTime = etime(t2, t1);
epiDist = distance(eventCords, sacvStaCords);
% plot parallel component
ah(1) = subplot(3,1,1);
hold on
plot(tims, parallel, 'color',[.1+(1/4) .1+(1/4) .1+(1/4)]);
if rotation == 'unrotated'
    ylabel(sprintf('North-South (%3.0f%s)', ...
        parAzimuth,char(176)));
elseif rotation == 'rotated'
    ylabel('Radial');
end
set(gca, 'xticklabels',[]);
ylim([yMin yMax]);
hold off
% orthogonal component
ah(2) = subplot(3,1,2);
plot(tims, orthogonal, 'Color',[.1+(2/4) .1+(2/4) .1+(2/4)]);
if rotation == 'unrotated'
    ylabel(sprintf('East-West (%3.0f%s)', ...
        orthAzimuth, char(176)));
else
    ylabel('Transverse');
end
set(gca, 'xticklabels',[]);
ylim([yMin yMax]);
hold off
% vertical component
ah(3) = subplot(3,1,3);
plot(tims, vertical, 'Color',[.1+(3/4) .1+(3/4) .1+(3/4)]);
ylabel('Vertical');
ylim([yMin yMax]);
set(gca, 'xtick', linspace(0, length(tims), 10), 'xtickLabel',linspace(0, elapTime, 10));
xticklabels(linspace(0, elapTime, 10));
suplabel('Time (s)', 'x');
hold off
% plot and label P- and S-wave Arrivals
if exist('pArriv', 'var')
    axes(ah(1));
    [xaf, y1] = ds2nfu([pArriv pArriv], [ah(1).YLim(2)  0]);
    axes(ah(3));
    [xaf, y2] = ds2nfu([pArriv pArriv], [ah(3).YLim(1)  0]);
    yaf = [y1(1) y2(1)];
    annotation('line', xaf, yaf, 'Color','r','linestyle','--','linewidth',1);
    an1 = annotation('textarrow', [xaf(2)-.04 xaf(2)-.01], [yaf(1)-.02 yaf(1)-.02], 'String','P-Wave Arrival','Color','r');
    [xaf, ~] = ds2nfu([sArriv sArriv], [0 0]);
    annotation('line', xaf, yaf, 'Color','b','linestyle','--','linewidth',1);
    an2 = annotation('textarrow', [xaf(2)-.04 xaf(2)-.01], [yaf(1)-.02 yaf(1)-.02], 'String','S-Wave Arrival','Color','b');
    % label
    titleDate = datestr(startT, 'mm/dd/yy HH:MM');
    tittle = sgtitle(sprintf('Magnitude %3.1f, Distance %4.1f%s, Depth %i, %s', ...
        magnitude, epiDist, char(176), depth, titleDate));
    suplabel('Time (s)', 'x');
else
    titleDate = datestr(startT, 'mm/dd/yy HH:MM');
    tittle = sgtitle(sprintf('Magnitude %3.1f, Distance %4.1f%s, Depth %i, %s', ...
        magnitude, epiDist, char(176), depth, titleDate));
    suplabel('Time (s)', 'x');
end
end

