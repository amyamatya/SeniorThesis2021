%% Example of seismic signal
% Last modified 1/13/21 by aamatya@princeton.edu

% Station info
network = 'II'; station = 'SACV'; channel = 'BH*'; location = '00';
% Get random traces of > magnitude 7 events
count = 1;
donutTraces2 = struct([]);
ids1 = find(donutQuakes2.mag > 7);
ids = randsample(ids1, 1);
% stationtraces
for i = 1:length(ids)
    eventCords = [donutQuakes2.lat(ids) convertLon(donutQuakes2.lon(ids), '360to-180')];
    
    startTime = donutQuakes2.time{ids(i)};
    endTime = datetime(startTime) + minutes(30);
    endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
    donutTraces2(i).quake = irisFetch.Traces(network,station,location,channel, startTime, endTime);
end
% plot unrotated components
figure(4)
for i = 1:3
    subplot(3,1,i)        
    plot(donutTraces2(1).quake(i).data)
%     azim = donutTraces2.quake(1).azimuth(1);
    if i == 1
        title(sprintf('Radial, az = %0.1f',donutTraces2.quake(1).azimuth));
    elseif i == 2
        title(sprintf('Transverse, az = %0.1f',donutTraces2.quake(2).azimuth));
    else title('Vertical');
    end
    if i ~= 3
        set(gca, 'xticklabels',[])
    end
    axis tight
end
t1 = datevec(startTime,'yyyy-mm-dd HH:MM:SS');
t2 = datevec(endTime,'yyyy-mm-dd HH:MM:SS');
elapTime = etime(t2, t1);
xticks(linspace(0, donutTraces2.quake(1).sampleCount, 10));
xticklabels(linspace(0, elapTime, 10));
suplabel('Time (seconds)', 'x');
sgtitle('Default 3 Component Seismogram');
% calculate travel times
evDep = donutTraces2.quake(1).depth;
% SACV coordinates
stationCords = [14.97 -23.608];
% Event coords
[timeTable, url] = mytaup(stationCords(1), stationCords(2), eventCords(1), eventCords(2), evDep);
% plot rotated components
startT = datestr(donutTraces2.quake(1).startTime, 'yyyy-mm-ddTHH:MM:SS');
endT = datestr(donutTraces2.quake(1).endTime, 'yyyy-mm-ddTHH:MM:SS');
[~, ~, ~, rad, trans, vert] = myrotate(startT, endT, azim);
figure(5)
hold on
pArriv = str2num(timeTable(1,4));
sArriv = str2num(timeTable(4,4));
sacplot3(rad, trans, vert, startT, endT, pArriv, sArriv);
hold off



