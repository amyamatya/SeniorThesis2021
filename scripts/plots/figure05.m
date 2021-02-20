% Figure05: SACV-SVMA Comparison
% Last modified 1/20/21 by aamatya@princeton.edu
sacvLat = 14.9700; sacvLon = -23.608;
svmaLat = 16.84; svmaLon = -24.92;
% Find largest shared quake
[sacvTrace, svmaTrace, sharedMag, sharedDep, sharedCords] = sharedTrace();
%% Plot multi-component seismogram
% run fetchRFQuakes first to get PZ Files
timeFormat = 'yyyy-mm-dd HH:MM:SS.FFF';
startTime = datestr(sacvTrace(1).startTime, timeFormat);
endTime = datestr(sacvTrace(1).endTime, timeFormat);
% Get transferred data and receiver functions
[sacvRF, sacvRad, sacvTrans, sacvVert] = componentFiles('II','SACV','10','BH*','sharedSACV',startTime, endTime, 8, 8.2);
[svmaRF, svmaRad, svmaTrans, svmaVert] = componentFiles('AF','SVMA','','BH*','sharedSVMA',startTime, endTime, 8, 8.2);
[timeTable, ~] = mytaup(sharedCords(1), convertLon(sharedCords(2),'360to-180'), sharedDep);
[row, ~] = find(strcmp(timeTable, 'P'));
pArriv = str2num(timeTable(row(1),4));
[row, ~] = find(strcmp(timeTable, 'S'));
sArriv = str2num(timeTable(row(1),4));
% Plot 
figure;
traceplot3(sacvTrace, sharedCords, 'unrotated');
title(sprintf('SACV Unprocessed'));
figure;
traceplot3(sacvTrace, sharedCords, 'rotated');
title(sprintf('SACV Rotated, Azimuth = %0.1f', azimuth(sharedCords, [sacvLat sacvLon])));
figure;
traceplot3(svmaTrace, sharedCords, 'unrotated');
title(sprintf('SVMA Unprocessed'));
figure;
traceplot3(svmaTrace, sharedCords, 'rotated');
title(sprintf('SVMA Rotated, Azimuth = %0.1f', azimuth(sharedCords, [svmaLat svmaLon])));
figure(5);
datplot3(sacvRad, sacvTrans, sacvVert, startTime, endTime, pArriv, sArriv);
figure(6); 
datplot3(svmaRad, svmaTrans, svmaVert, startTime, endTime, pArriv, sArriv);



close all
figure,
subplot(3,6,[1:4])
plot(sacvRad)
subplot(3,5,[4:5 9:10 14:15])
plot(sacvRF)
subplot(3,5,[6:8])
plot(sacvTrans)
subplot(3,5,[11:13])
plot(sacvVert)
hold off
figure,
subplot(3,8,[1:5])
plot(svmaRad)
subplot(3,8,[6:8 14:16 22:24])
plot(svmaRF)
subplot(3,8,[9:13])
plot(svmaTrans)
subplot(3,8,[17:21])
plot(svmaVert)
hold off
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/fleija','-fillpage','-dpdf');


