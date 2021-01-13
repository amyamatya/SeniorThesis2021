function [plop] = sacplot3(rad, trans, vert, startT, endT, pArriv, sArriv)
% 3 component plot of given sacfile with labeled arrival
% last edit 12/29 aamatya

plop = figure;
% plot radial component
subplot(3,1,1)
hold on
[rad, ~, ~, ~, tims] = readsac(rad);
duration = eIristime(startT, endT);
plot(tims, rad,'Color',[.5 .5 .5]);
set(gca, 'xticklabel',[]);
title('Radial');
axis tight
hold off
% plot transverse component
subplot(3,1,2)
hold on
[trans, ~, ~, ~, tims] = readsac(trans);
plot(tims, trans,'Color',[.5 .5 .5]);
set(gca, 'xticklabel',[]);
title('Transverse');
axis tight
hold off
% plot vertical component
subplot(3,1,3)
hold on
[vert, ~, ~, ~, tims] = readsac(vert);
plot(tims, vert,'Color',[.5 .5 .5]);
title('Vertical');
axis tight
hold off
% plot and label P- and S-wave Arrivals
ax = gca;
[xaf, yaf] = ds2nfu([pArriv pArriv], [ax.YLim(1) - 100 ax.YLim(2) * 5.9]);
annotation('line', xaf, yaf, 'Color','r','linestyle','--','linewidth',1);
[xaf, yaf] = ds2nfu([sArriv sArriv], [ax.YLim(1) - 100 ax.YLim(2) * 5.9]);
annotation('line', xaf, yaf, 'Color','b','linestyle','--','linewidth',1);
annotation('textarrow', [0.35 0.39], [0.8 0.8], 'String','P-Wave Arrival','Color','r');
annotation('textarrow', [0.56 0.6], [0.8 0.8], 'String','S-Wave Arrival','Color','b');
% label
sgtitle('Rotated 3-Component Seismogram');
suplabel('Counts','y');
xticks(linspace(0, length(tims), 10));
xticklabels(linspace(0, duration, 10));
suplabel('Time (seconds)', 'x');
end

