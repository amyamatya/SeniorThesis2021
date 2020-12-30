function [plop] = sacplot3(rad, trans, vert, startT, endT)
% 3 component plot of given sacfile
% last edit 12/29 aamatya

plop = figure;
subplot(3,1,1)
rad = readsac(rad);
duration = eIristime(startT, endT);
plot(rad);
set(gca, 'xticklabel',[]);
title('Radial');

subplot(3,1,2)
trans = readsac(trans);
plot(trans);
set(gca, 'xticklabel',[]);
title('Transverse');

subplot(3,1,3)
vert = readsac(vert);
plot(vert);
title('Vertical');

x = linspace(0, duration, length(rad));
xticklabels(round(x, 3));
sgtitle('3-Component Seismogram');
suplabel('Counts','y');
end

