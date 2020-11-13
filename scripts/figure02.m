%% 1 - Histogram of magnitudes
% Skip to Section 2 if ran startup.m
% Get station info (Network II, Location 00, BH)
s1 = irisFetch.Stations('CHANNEL','II','SACV','00','BH*'); 
s1la = s1.Channels(1).Latitude;
s1lo = s1.Channels(1).Longitude;
t1 = s1.Channels(1).StartDate;
t2 = s1.Channels(18).StartDate;
% A donut = [Lat, Lon, MaxRadius, MinRadius]
donut = [s1la s1lo 90 30]; 
minMag = 3; maxMag = 9;
% Donut events from 1/14/13
ev1Donut = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude', maxMag,...
    'radialcoordinates',donut, 'startTime',t1);
% All and Donut events from 11/10/17
ev2All = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude', maxMag,'startTime',t2);
ev2Donut = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude', maxMag,...
    'radialcoordinates',donut, 'startTime',t2);
%% 2 - Store quake info
% Donut events from 1/14/13
donutQuakes1.mag = [ev1Donut.PreferredMagnitudeValue]';
donutQuakes1.lat = [ev1Donut.PreferredLatitude]';
donutQuakes1.lon = convertLon([ev1Donut.PreferredLongitude]', '-180to360');
donutQuakes1.depth = [ev1Donut.PreferredDepth]';
donutQuakes1.time = string({ev1Donut.PreferredTime}');
endtimeDonut1 = datetime(donutQuakes1.time) + hours(0.1);
endtimeDonut1 = datestr(endtimeDonut1, 'yyyy-mm-dd HH:MM:SS.FFF');
% All events from 11/10/17
allQuakes.mag = [ev2All.PreferredMagnitudeValue]';
allQuakes.lat = [ev2All.PreferredLatitude]';
allQuakes.lon = convertLon([ev2All.PreferredLongitude]', '-180to360');
allQuakes.depth = [ev2All.PreferredDepth]';
allQuakes.time = string({ev2All.PreferredTime}');
endtimeAll = datetime(allQuakes.time) + hours(0.1);
endtimeAll = datestr(endtimeAll, 'yyyy-mm-dd HH:MM:SS.FFF');
% Donut events from 11/10/17
donutQuakes2.mag = [ev2Donut.PreferredMagnitudeValue]';
donutQuakes2.lat = [ev2Donut.PreferredLatitude]';
donutQuakes2.lon = convertLon([ev2Donut.PreferredLongitude]', '-180to360');
donutQuakes2.depth = [ev2Donut.PreferredDepth]';
donutQuakes2.time = string({ev2Donut.PreferredTime}');
endtimeDonut2 = datetime(donutQuakes2.time) + hours(0.1);
endtimeDonut2 = datestr(endtimeDonut2, 'yyyy-mm-dd HH:MM:SS.FFF');
% Get magnitude types + frequencies
% Most common: Mb/mb (body wave), Md/md (duration), ML/Ml (local magnitude),...
% MW/Mw (moment magnitude)
names = string({ev1Donut.PreferredMagnitudeType});
magTypes = unique(names);
magFreqs = zeros(length(magTypes),1);
for i = 1:length(magTypes)
    magFreqs(i) = length(find(names == magTypes(i)));
end
[magFreqs, id] = sort(magFreqs,'descend');
magTypes = magTypes(id);
%%
% Make histogram, donut color coded
close all
figure(2)
subplot(2,1,1)
% histogram([allQuakes.mag], 14, 'binedges',3:.5:9);
allCounts = histcounts(allQuakes.mag, 3:.5:9);
donutCounts1 = histcounts(donutQuakes1.mag, 3:.5:9);
donutCounts2 = histcounts(donutQuakes2.mag, 3:.5:9);
bar(1:length(allCounts), [allCounts; donutCounts2]','histc');
axis tight
title('Frequency of Earthquake Magnitudes');
set(gca,'xticklabel',[]);
legend('All data from 11/10/17','Donut data from 11/10/17');
hold off

subplot(2,1,2)
bar(1:length(allCounts), [allCounts; donutCounts2]','histc');
ph = get(gca,'children');
for i = 1:length(ph)
      % Get patch vertices
      vn = get(ph(i),'Vertices');
      % Adjust y location
      vn(:,2) = vn(:,2) + 1;
      % Reset data
      set(ph(i),'Vertices',vn)
end
% Change scale
set(gca,'yscale','log')
axis tight
title('Log Frequency of Earthquake Magnitudes');
set(gca,'YTickLabel',[]);
xticklabels(3:0.5:9.5);
% difference between magnitudes
suplabel('Magnitude','x');
suplabel('Counts','y');
print(figure(2), '/Users/aamatya/Desktop/Thesis/Figures/figure02','-dpdf');


% Clean workspace
% clearvars -except ev filename land levels quakes shorelines

% peepee poopoo 
