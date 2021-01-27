function [tittle] = sacplot3(rad, trans, vert, startT, endT, pArriv, sArriv)
% 3 component plot of given sacfile with labeled arrival
% last edit 1/13/21 aamatya

% store data, find limits
t1 = datevec(startT,'yyyy-mm-ddTHH:MM:SS');
t2 = datevec(endT,'yyyy-mm-ddTHH:MM:SS');
elapTime = etime(t2, t1);
[rad, ~, ~, ~, tims] = readsac(rad);
[trans, ~, ~, ~, ~] = readsac(trans);
[vert, ~, ~, ~, ~] = readsac(vert);
yMin = min(min([rad trans vert]));
yMax = max(max([rad trans vert]));

% plot radial component
ah(1) = subplot(3,1,1);
hold on
duration = eIristime(startT, endT);
plot(tims, rad,'Color',[.1+(1/4) .1+(1/4) .1+(1/4)]);
% plot(tims, rad);
set(gca, 'xticklabel',[]);
ylabel('Radial');
box on
axis tight
ylim([yMin yMax]);
hold off
% plot transverse component
ah(2) = subplot(3,1,2);
hold on
plot(tims, trans,'Color',[.1+(2/4) .1+(2/4) .1+(2/4)]);
% plot(tims, trans);
set(gca, 'xticklabel',[]);
ylabel('Transverse');
box on
axis tight
ylim([yMin yMax]);
hold off
% plot vertical component
ah(3) = subplot(3,1,3);
hold on
plot(tims, vert,'Color',[.1+(3/4) .1+(3/4) .1+(3/4)]);
% plot(tims, vert);
set(gca, 'xtick', linspace(0, length(tims), 10), 'xtickLabel',linspace(0, elapTime, 10));
ylabel('Vertical');
box on
axis tight
ylim([yMin yMax]);
hold off
% plot and label P- and S-wave Arrivals
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
tittle = sgtitle('Rotated 3-Component Seismogram');
suplabel('Time (s)', 'x');
end

