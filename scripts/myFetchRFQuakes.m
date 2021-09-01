function [] = myFetchRFQuakes(network, station, location, channel, sacDir, minMag, maxMag, fetchStart, fetchEnd)
% Adaptation of fetchRFQuakes.m from aburky@princeton.edu to take inputs
% Fetch traces and pole-zero data from SACV station
%---------Input Variables------------------------------------
% sacDir                   - destination path for output SAC files
% minMag, maxMag           - query magnitudes
% fetchStart, fetchEnd     - query times ('yyyy-mm-dd HH:MM:SS')
%------------------------------------------------------------
ch = irisFetch.Channels('RESPONSE',network,station,location,channel);
if ~exist(sacDir,'dir')
    mkdir(sacDir)
elseif exist(sacDir,'dir') == 7
    disp('Receiver function directory already exists! Deleting it...')
    rmdir(sacDir,'s')
    mkdir(sacDir)
end
% Loop over each channel and make the PZ file
for i = 1:length(ch)
    % While we are iterating over the channel, check for earthquakes
    % that meet our search criterion during its operation
    donut = [14.97, -23.608, 90, 30];
    ev = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude',...
        maxMag,'radialcoordinates',donut,'startTime',fetchStart,...
        'endTime',fetchEnd);
    % Loop over each event, get the trace for the channel, and save
    for j = 1:length(ev)
        ev_start = fetchStart;
        ev_end = fetchEnd;
        % Fetch trace data from the current channel
        tr = irisFetch.Traces(network,station,location,...
            ch(i).ChannelCode,ev_start,ev_end);
        % Save the trace data to a SAC file
        if ~isempty(tr) && length(tr) == 1
            saveSAC(tr,ev_start,sacDir,'event',ev(j),'pz',i);
        end
    end
end
end