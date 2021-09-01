function [theFig] = datplot3(rad, trans, vert, startT, endT, pArriv, sArriv)
% Plot 3 component seismogram with marked arrivals
% Last edit 2/17/21 @aamatya
%---------Input Variables------------------------------------
% rad, trans, vert              - trace data (nx1 array)
% startT, endT                  - event times ('yyyy-mm-dd HH:MM:SS')
% pArriv, sArriv                - arrival times (s)
%------------------------------------------------------------
% calculate trace duration, distance, depths
t1 = datestr(startT,'yyyy-mm-ddTHH:MM:SS');
t2 = datestr(endT,'yyyy-mm-ddTHH:MM:SS');
elapTime = eIristime(t1, t2);
tims = linspace(0, elapTime, length(rad));
yMin = min(min([rad; trans; vert]));
yMax = max(max([rad ;trans; vert]));
% plot parallel component
ah(1) = subplot(3,1,1);
hold on
plot(tims, rad, 'color',[.1+(1/4) .1+(1/4) .1+(1/4)]);
box on
set(gca, 'xticklabels',[]);
ylim([yMin yMax]);
hold off
% orthogonal component
ah(2) = subplot(3,1,2);
plot(tims, trans, 'Color',[.1+(2/4) .1+(2/4) .1+(2/4)]);
box on
set(gca, 'xticklabels',[]);
ylim([yMin yMax]);
hold off
% vertical component
ah(3) = subplot(3,1,3);
plot(tims, vert, 'Color',[.1+(3/4) .1+(3/4) .1+(3/4)]);
box on
ylim([yMin yMax]);
set(gca, 'xtick', linspace(0, elapTime, 10), 'xtickLabel',linspace(0, elapTime, 10));
% xticklabels(linspace(0, elapTime, 10));
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
    suplabel('Time (s)', 'x');
else
    suplabel('Time (s)', 'x');
end
theFig = gcf;
end