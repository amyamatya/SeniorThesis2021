% Figure05: SACV-SVMA Comparison
% Last modified 1/20/21 by aamatya@princeton.edu
sacvLat = 14.9700; sacvLon = -23.608;
svmaLat = 16.84; svmaLon = -24.92;
% Find largest shared quake
[sacvTrace, svmaTrace, sharedMag, sharedDep, sharedCords, sharedDist] = sharedTrace();
%% Plot multi-component seismogram
% run fetchRFQuakes first to get PZ Files
timeFormat = 'yyyy-mm-dd HH:MM:SS.FFF';
startTime = datestr(sacvTrace(1).startTime, timeFormat);
endTime = datestr(sacvTrace(1).endTime, timeFormat);
% Get transferred data and receiver functions
[sacvRF, sacvRad, sacvTrans, sacvVert] = componentFiles('II','SACV',...
    '10','BH*','sharedSACV',startTime, endTime, 8, 8.2);
[svmaRF, svmaRad, svmaTrans, svmaVert] = componentFiles('AF','SVMA',...
    '','BH*','sharedSVMA',startTime, endTime, 8, 8.2);
[timeTable, ~] = mytaup(sharedCords(1), convertLon(sharedCords(2),...
    '360to-180'), sharedDep);
[row, ~] = find(strcmp(timeTable, 'P'));
pArriv = str2num(timeTable(row(1),4));
[row, ~] = find(strcmp(timeTable, 'S'));
sArriv = str2num(timeTable(row(1),4));
%% Plot
% clf
% traceplot3(sacvTrace, sharedCords, 'unrotated');
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure01','-dpdf','-r600');
% clf
% traceplot3(sacvTrace, sharedCords, 'rotated');
% title(sprintf('Azimuth = %0.1f', azimuth(sharedCords, [sacvLat sacvLon])));
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure02','-dpdf','-r600');
% clf
datplot3(sacvRad, sacvTrans, sacvVert, startTime, endTime, pArriv, sArriv);
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure03','-dpdf','-r600');
% clf
% traceplot3(svmaTrace, sharedCords, 'unrotated');
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure04','-dpdf','-r600');
% clf
% traceplot3(svmaTrace, sharedCords, 'rotated');
% title(sprintf('Azimuth = %0.1f', azimuth(sharedCords, [svmaLat svmaLon])));
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure05','-dpdf','-r600');
clf
datplot3(svmaRad, svmaTrans, svmaVert, startTime, endTime, pArriv, sArriv);
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure06','-dpdf','-r600');

%%
clf
plot(sacvRF);
title('SACV Receiver Function');
axis tight
ax = gca;
ax.XGrid = 'on';
xlabel('Time (s)');
ylabel('$\bar{f}_{Z \rightarrow R}(p,z)$','Interpreter','Latex')
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure07','-dpdf','-r600');

clf
plot(svmaRF);
title('SVMA Receiver Function');
axis tight
ax = gca;
ax.XGrid = 'on';
xlabel('Time (s)');
ylabel('$\bar{f}_{Z \rightarrow R}(p,z)$','Interpreter','Latex')
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure05/figure08','-dpdf','-r600');



