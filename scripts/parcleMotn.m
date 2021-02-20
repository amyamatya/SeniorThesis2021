function [tittle] = parcleMotn(NS, EW, Zee, pArriv, sArriv, sampRate, ranj1, ranj2)
% Particle motion diagrams - (P-wave in R-Z, P wave in T-R, S wave in R-Z)
% last updated @aamatya 2/20/2021
%---------Input Variables------------------------------------
% NS, EW, Zee           - radial, transverse, vertical data (nx1 array)
% pArriv, sArriv        - arrival times (s)
% sampRate              - instrument sample rate
% ranj1                 - P-wave period duration (sample points)
% ranj2                 - S-wave period duration (sample points)
%-----------------------------------------------------------
pStart = ceil(pArriv) * sampRate;
pEnd = pStart + ranj1;
sStart = ceil(sArriv) * sampRate;
sEnd = sStart + ranj2;
format bank
% Universal axes limits
nsMin = min(min([NS(pStart:pEnd) NS(sStart:sEnd)]));
nsMax = max(max([NS(pStart:pEnd) NS(sStart:sEnd)]));
ewMin = min(min([EW(pStart:pEnd) EW(sStart:sEnd)]));
ewMax = max(max([EW(pStart:pEnd) EW(sStart:sEnd)]));
zeeMin = min(min([zee(pStart:pEnd) zee(sStart:sEnd)]));
zeeMax = max(max([zee(pStart:pEnd) zee(sStart:sEnd)]));
% P-wave in R-Z
subplot(2,2,1);
hold on
scatter(NS(pStart:pEnd), Zee(pStart:pEnd), 10, linspace(0,1,length(pStart:pEnd)),'filled')
colormap(gray); 
cb = colorbar;
cb.Label.String = 'Time (s)';
set(cb, 'ticks',linspace(0, 1, 5));
set(cb, 'ticklabels',linspace(0, ranj1/sampRate, 5));
xlabel('R [South (-) North (+)]'); %EW [West (-) East (+)]');
ylabel('Z [Down (-) Up (+)]');
box on
axis equal
title('P Wave in R-Z');
hold off
% p-wave in T-R
subplot(2,2,2);
scatter(EW(pStart:pEnd), NS(pStart:pEnd), 10, linspace(0,1,length(pStart:pEnd)),'filled')
colormap(gray); 
cb = colorbar;
cb.Label.String = 'Time (s)';
set(cb, 'ticks',linspace(0, 1, 5));
set(cb, 'ticklabels',linspace(0, ranj1/sampRate, 5));
xlabel('T [West (-) East (+)]');
ylabel('R [South (-) North (+)]');
box on
hold on
axis equal
title('P Wave in T-R');
hold off
% s-wave in R-Z
subplot(2,2,3)
hold on
scatter(NS(sStart:sEnd), Zee(sStart:sEnd), 10, linspace(0,1,length(sStart:sEnd)),'filled')
colormap(gray); 
cb = colorbar;
cb.Label.String = 'Time (s)';
set(cb, 'ticks',linspace(0, 1, 5));
set(cb, 'ticklabels',linspace(0, ranj2/sampRate, 5));
xlabel('R [South (-) North (+)]'); %EW [West (-) East (+)]');
ylabel('Zee [Down (-) Up (+)]');
axis equal
title('S Wave in R-Z');
hold off
tittle = sgtitle('Particle Motion');
% Label 1 through 10 time-ascending order
% for i = 1:10
%     ids = linspace(sStart, sEnd, 10);
%     text(NS(floor(ids(i))), Zee(floor(ids(i))), sprintf('%d', i));
% end
end