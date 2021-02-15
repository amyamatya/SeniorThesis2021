function [sacvGet, sacvEvents] = getEvents(station, minRadius, maxRadius,minMag, maxMag)
% Fetch events from Cape Verde station incrementally to avoid overload
% Last modified 2/13/21 @aamatya
%---Input variables------------
% station       - SACV or SVMA
% minRadius     - lower limit for donut
% maxRadius     - upper limit for donut
% minMag        - lower limit magnitude
% maxMag        - upper limit magnitude
%---Output variables------------
% sacvGet       - struct of fetched event info
% sacvEvents    - struct of mag, location, depth, time

% Get station info
if station == 'SACV'
    staCords = [14.97 -23.608];
    s1 = irisFetch.Stations('CHANNEL','II','SACV','00','BH*');
    t1 = s1.Channels(5).StartDate;
    donut = [staCords(1) staCords(2) maxRadius minRadius];
else
    staCords = [16.840389 -24.924999];
    s1 = irisFetch.Stations('CHANNEL','AF','SVMA','','BH*');
    t1 = s1.Channels(1).StartDate;
    donut = [staCords(1) staCords(2) maxRadius minRadius];
end
% Fetch events in 0.1 magnitude increments
sacvGet = [];
for i = minMag:0.1:maxMag
    i = i+1e-4;
    try
        sacvGet = [sacvGet irisFetch.Events('MinimumMagnitude',i,'MaximumMagnitude', i+9.99e-2,...
            'radialcoordinates',donut, 'startTime',t1)];
    catch
        continue
    end
end
% Store event info
if isempty(sacvGet) 
    sacvEvents = [];
    disp('No events found.');
else
    sacvEvents.mag = [sacvGet.PreferredMagnitudeValue]';
    sacvEvents.lat = [sacvGet.PreferredLatitude]';
    sacvEvents.lon = convertLon([sacvGet.PreferredLongitude]', '-180to360');
    sacvEvents.depth = [sacvGet.PreferredDepth]';
    sacvEvents.time = string({sacvGet.PreferredTime}');
end
end