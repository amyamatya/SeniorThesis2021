% Figure05: SACV-SVMA Comparison
% Last modified 1/20/21 by aamatya@princeton.edu
sacvLat = 14.9700; sacvLon = -23.608;
svmaLat = 16.84; svmaLon = -24.92;
% Find largest shared quake
[sacvTrace, svmaTrace, sharedMag, sharedDep, sharedCords] = sharedTrace();
%% Plot multi-component seismogram

epiDistSacv = distance(sharedCords, [sacvTrace(1).latitude sacvTrace(1).longitude]);
epiDistSvma = distance(sharedCords, [svmaTrace(1).latitude svmaTrace(1).longitude]);

figure, traceplot3(svmaTrace, sharedCords, 'unrotated');
figure, traceplot3(svmaTrace, sharedCords, 'rotated');
figure, traceplot3(sacvTrace, sharedCords, 'unrotated');
figure, traceplot3(sacvTrace, sharedCords, 'rotated');
%%

% Plot 3 component seismogram
figure(1)
clf
evDep = sacvEvents.depth(ids);
datplot3(eventCords, evDep, sacvTraces(1).traces(1).data,sacvTraces(1).traces(2).data, ...
    sacvTraces(1).traces(3).data, 'unrotated', startTime, endTime, sacvEvents.mag(ids), sacvTraces(1).traces(1).azimuth,...
    sacvTraces(1).traces(2).azimuth);
% calculate travel times
[timeTable, url] = mytaup(eventCords(1), eventCords(2), evDep);
startT = datestr(sacvTraces(1).traces(1).startTime, 'yyyy-mm-ddTHH:MM:SS');
endT = datestr(sacvTraces(1).traces(1).endTime, 'yyyy-mm-ddTHH:MM:SS');
[~, ~, ~, rad, trans, vert] = myrotate(startT, endT, azim);
hold on
pArriv = str2num(timeTable(1,4));
sArriv = str2num(timeTable(4,4));
ranj1 = 400;
ranj2 = 1200;



%% plot rotated components + particle motion
figure(2)
clf
subplot(1,2,1)
[tittle] = sacplot3(rad, trans, vert, startT, endT, pArriv, sArriv);
tittle.String = sprintf('Magnitude %3.1f, Distance %4.1f %s, %s',...
    sacvEvents.mag(ids), distance(eventCords, sacvStaCords), char(176), datestr(startTime));

subplot(1,2,2)
parcleMotn(rdat, tdat, sacvTraces(1).traces(3).data,...
    pArriv, sArriv, sacvTraces(1).traces(1).sampleRate, ranj1, ranj2);

