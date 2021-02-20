function [sacvTraceIn, svmaTraceIn, mag, dep, coords] = sharedTrace()
% Return the largest complete trace shared by both SACV and SVMA
% Last modified 2/19/21 by aamatya@princeton.edu


sacvLat = 14.9700; sacvLon = -23.608;
svmaLat = 16.84; svmaLon = -24.92;
[~,sacvEvents] = getEvents('SACV',0,180, 6,7);
[~,svmaEvents] = getEvents('SVMA',0,180, 6,7);
% Sort by magnitude
[sacvEvents.mag,sacvIdx] = sort(sacvEvents.mag);
sacvEvents.lat = sacvEvents.lat(sacvIdx);
sacvEvents.lon = sacvEvents.lon(sacvIdx);
[sacvEvents.mag,svmaIdx] = sort(svmaEvents.mag);
svmaEvents.lat = svmaEvents.lat(svmaIdx);
svmaEvents.lon = svmaEvents.lon(svmaIdx);
% Biggest shared SACV/SVMA quake
svmaDist = distance(svmaLat, svmaLon, svmaEvents.lat, svmaEvents.lon);
svmaID = find(svmaDist > 30 & svmaDist < 90);
for i = length(svmaID)-1:-1:1
    ID = svmaID(i);
    theDate = svmaEvents.time(ID);
    theDate = extractBetween(theDate, 1, 15);
    theMatch = regexp(sacvEvents.time, regexptranslate('wildcard',sprintf('%s*', theDate)));
    sacvID = find(cellfun(@isempty, theMatch) == 0);
    startTime = sacvEvents.time(sacvID);
    endTime = datetime(startTime) + minutes(30);
    endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
    try
        sacvTraceIn = irisFetch.Traces('II','SACV','00','BH*', startTime, endTime);
        svmaTraceIn = irisFetch.Traces('AF','SVMA','','BH*', startTime, endTime); 
    catch
    end
    if (length(sacvTraceIn) >= 2 ) && (length(svmaTraceIn) >= 2)
        mag = sacvEvents.mag(ID);
        dep = sacvEvents.depth(ID);
        coords = [sacvEvents.lat(ID) convertLon(sacvEvents.lon(ID),'-180to360')];
        break
    end
end
end