%%

network = 'II';
station = 'SACV';
channel = 'BH*';
location = '00';


% Get station
s = irisFetch.Stations('CHANNEL','II','SACV','00','BH*'); 
stla = s.Channels(18).Latitude;
stlo = s.Channels(18).Longitude;
t1 = s.Channels(18).StartDate;
% [Lat, Lon, MaxRadius, MinRadius]
donut = [stla stlo 90 30]; 
minMag = 7.0;
maxMag = 7.5;
% Get events
ev = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude',maxMag,...
    'radialcoordinates',donut,'startTime',t1);
evla = ev(1).PreferredLatitude;
evlo = ev(1).PreferredLongitude;
evdp = ev(1).PreferredDepth;
evtime = ev(1).PreferredTime;
% Get hour after event
endtime = datetime(evtime) + hours(1);
endtime = datestr(endtime, 'yyyy-mm-dd HH:MM:SS.FFF');
% Get traces
tr = irisFetch.Traces('IU',station,location,channel,evtime,endtime);




