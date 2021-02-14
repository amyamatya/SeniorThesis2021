function [sacvGet] = getSacvEvents(minRadius, maxRadius,minMag, maxMag)
% Fetch events for station SACV incrementally to avoid overload
% Last modified 2/13/21 @aamatya
%---Input variables------------
% minRadius     - lower limit for donut
% maxRadius     - upper limit for donut
% minMag        - lower limit magnitude
% maxMag        - upper limit magnitude
sacvStaCords = [14.97 -23.608];
s1 = irisFetch.Stations('CHANNEL','II','SACV','00','BH*');
t1 = s1.Channels(5).StartDate; % Earliest = channel 5
sacvDonut = [sacvStaCords(1) sacvStaCords(2) maxRadius minRadius];
sacvGet = [];
for i = minMag:0.1:maxMag
    i = i+1e-4;
    try
        sacvGet = [sacvGet irisFetch.Events('MinimumMagnitude',i,'MaximumMagnitude', i+9.99e-2,...
            'radialcoordinates',sacvDonut, 'startTime',t1)];
    catch
        continue
    end
end

