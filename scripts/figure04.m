%% Example of seismic signal
% Last modified 11/15/2020 by aamatya@princeton.edu

% Station info
network = 'II'; station = 'SACV'; channel = 'BH*'; location = '00';
% Get random traces
count = 1;
allTraces = struct([]);
ids = randi(length(allQuakes.mag), 10,1);
% constrain ids by magnitude
for i = 1:length(ids)
    %     convert time
    startTime = allQuakes.time{ids(i)};
    endTime = datetime(startTime) + hours(1);
    endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
    allTraces(i).quake = irisFetch.Traces(network,station,location,channel, startTime, endTime);
end

figure(4)
for i = 1:3
    subplot(3,1,i)
    plot(allTraces(1).quake(i).data)
    axis tight
end




