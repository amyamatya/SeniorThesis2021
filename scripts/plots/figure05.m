% Example of seismic signal
% Last modified 1/20/21 by aamatya@princeton.edu
% Load retrievals from 5/29/2000 > magnitude 6
sacvLat = 14.9700; sacvLon = convertLon(-23.608, '-180to360');
svmaLat = 16.84; svmaLon = convertLon(-24.92, '-180to360');
[~,sacvEvents] = getEvents('SACV',0,180, 7.5, 10);
[~,svmaEvents] = getEvents('SVMA',0,180, 7.5, 10);
% Sort by magnitude
[sacvEvents.mag,sacvIdx] = sort(sacvEvents.mag);
sacvEvents.lat = sacvEvents.lat(sacvIdx);
sacvEvents.lon = sacvEvents.lon(sacvIdx);
[sacvEvents.mag,svmaIdx] = sort(svmaEvents.mag);
svmaEvents.lat = svmaEvents.lat(svmaIdx);
svmaEvents.lat = svmaEvents.lat(svmaIdx);
% Biggest shared quake inside donut
svmaDist = distance(svmaLat, svmaLon, svmaEvents.lat, svmaEvents.lon);
svmaID = find(svmaDist > 30 & svmaDist < 90);
svmaID = svmaID(end);
theDate = svmaEvents.time(svmaID);
theDate = extractBetween(theDate, 1, 10);
theMatch = regexp(sacvEvents.time, regexptranslate('wildcard',sprintf('%s*', theDate)));
sacvID = find(cellfun(@isempty, theMatch) == 0);
% Biggest shared quake outside donut
svmaIDOut = find(svmaDist < 30 | svmaDist > 90);
svmaIDOut = svmaIDOut(end-5);
theDateOut = svmaEvents.time(svmaIDOut);
theDateOut = extractBetween(theDateOut, 1, 10);
theMatchOut = regexp(sacvEvents.time, regexptranslate('wildcard',sprintf('%s*', theDateOut)));
sacvIDOut = find(cellfun(@isempty, theMatchOut) == 0);
% Get traces (SACV donut, SACV out donut, SVMA donut, SVMA out donut)
eventCords = [sacvEvents.lat(sacvID) convertLon(sacvEvents.lon(sacvID), '360to-180')];
startTime = sacvEvents.time(sacvID);
endTime = datetime(startTime) + minutes(30);
endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
try
sacvTraceIn = irisFetch.Traces('II','SACV','00','BH*', startTime, endTime);
catch
end
sacvTraceInAzim = azimuth(eventCords, [sacvLat convertLon(sacvLon,'360to-180')]);
eventCords = [sacvEvents.lat(sacvIDOut) convertLon(sacvEvents.lon(sacvIDOut), '360to-180')];
startTime = sacvEvents.time(sacvIDOut);
endTime = datetime(startTime) + minutes(30);
endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
try
sacvTraceOut = irisFetch.Traces('II','SACV','00','BH*', startTime, endTime);
catch
end
sacvTraceOutAzim = azimuth(eventCords, [sacvLat convertLon(sacvLon,'360to-180')]);
eventCords = [svmaEvents.lat(svmaID) convertLon(svmaEvents.lon(svmaID), '360to-180')];
startTime = svmaEvents.time(svmaID);
endTime = datetime(startTime) + minutes(30);
endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
try
svmaTraceIn = irisFetch.Traces('AF','SVMA','','BH*', startTime, endTime);
catch
end
svmmaTraceInAzim = azimuth(eventCords, [sacvLat convertLon(sacvLon,'360to-180')]);
eventCords = [svmaEvents.lat(svmaIDOut) convertLon(svmaEvents.lon(svmaIDOut), '360to-180')];
startTime = svmaEvents.time(svmaIDOut);
endTime = datetime(startTime) + minutes(30);
endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
try
svmaTraceOut = irisFetch.Traces('AF','SVMA','','BH*', startTime, endTime);
catch
end
sacvTraceOutAzim = azimuth(eventCords, [sacvLat convertLon(sacvLon,'360to-180')]);
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

