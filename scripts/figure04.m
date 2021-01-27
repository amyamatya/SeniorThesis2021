% Example of seismic signal
% Last modified 1/20/21 by aamatya@princeton.edu
%% Only run this once: Get SACV retrievals from 5/29/2000 > magnitude 6
sacvStaCords = [14.97 -23.608];
s1 = irisFetch.Stations('CHANNEL','II','SACV','00','BH*');
t1 = s1.Channels(5).StartDate; % Earliest = channel 5
sacvDonut = [sacvStaCords(1) sacvStaCords(2) 90 30];
minMag = 6; maxMag = 9;
sacvGet= irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude', maxMag,...
    'radialcoordinates',sacvDonut, 'startTime',t1, 'includePZ');
sacvEvents.mag = [sacvGet.PreferredMagnitudeValue]';
sacvEvents.lat = [sacvGet.PreferredLatitude]';
sacvEvents.lon = convertLon([sacvGet.PreferredLongitude]', '-180to360');
sacvEvents.depth = [sacvGet.PreferredDepth]';
sacvEvents.time = string({sacvGet.PreferredTime}');
% % % Get SMVA retrievals from 11/10/2017
% % svmaStaCords = [16.840389 -24.924999];
% % s2 = irisFetch.Stations('CHANNEL','AF','SVMA','','BH*');
% % t2 = s2.Channels(1).StartDate;
% % svmaDonut = [svmaStaCords(1) svmaStaCords(2) 90 30];
% % svmaEvents = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude', maxMag,...
% %     'radialcoordinates',svmaDonut, 'startTime',t2);
%% Get random traces of > magnitude 6 SACV events
count = 1;
sacvTraces = struct([]);
ids = randi(length(sacvEvents.mag));
ids = 2;
% station traces
for i = 1:length(ids)
    eventCords = [sacvEvents.lat(ids(i)) convertLon(sacvEvents.lon(ids(i)), '360to-180')];
    startTime = sacvEvents.time{ids(i)};
    endTime = datetime(startTime) + minutes(30);
    endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
    sacvTraces(i).traces = irisFetch.Traces('II','SACV','00','BH*', startTime, endTime);
    azim = azimuth(eventCords, sacvStaCords);
    try
        [ndat, edat] = seisne(sacvTraces(i).traces(1).data, sacvTraces(i).traces(2).data, sacvTraces(i).traces(1).azimuth);
        [rdat, tdat] = seisrt(ndat, edat, backAzim(azim));
    catch
        continue
    end
end
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
ranj = 600;
% plot rotated components + particle motion
figure(2)
clf
subplot(1,2,1)
[tittle] = sacplot3(rad, trans, vert, startT, endT, pArriv, sArriv);
tittle.String = sprintf('Magnitude %3.1f, Distance %4.1f %s, %s',...
    sacvEvents.mag(ids), distance(eventCords, sacvStaCords), char(176), datestr(startTime));

subplot(1,2,2)
parcleMotn(rdat, tdat, sacvTraces(1).traces(3).data,...
    pArriv, sArriv, sacvTraces(1).traces(1).sampleRate, ranj);
