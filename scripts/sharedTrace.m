function [sacvTraceIn, svmaTraceIn, mag, dep, coords, shareDist] = sharedTrace()
% Return the largest SACV-SVMA shared trace with at least 2 components
% Last modified 2/19/21 by aamatya@princeton.edu
%---------Output Variables--------------------------------------
% sacvTraceIn               - largest shared SACV trace
% svmaTraceIn               - largest shared SVMA trace
% mag, dep, coords          - magnitude, depth, location of shared event
% sharedDist(1)             - svma
% sharedDist(2)             - sacv 
%---------------------------------------------------------------
sacvLat = 14.9700; sacvLon = -23.608;
svmaLat = 16.84; svmaLon = -24.92;
[~,sacvEvents] = getEvents('SACV',30,90, 6,9);
[~,svmaEvents] = getEvents('SVMA',30,90, 6,9);
% Sort by magnitude
[sacvEvents.mag,sacvIdx] = sort(sacvEvents.mag);
sacvEvents.lat = sacvEvents.lat(sacvIdx);
size(sacvEvents.lat)
sacvEvents.lon = sacvEvents.lon(sacvIdx);
[sacvEvents.mag,svmaIdx] = sort(svmaEvents.mag);
svmaEvents.lat = svmaEvents.lat(svmaIdx);
svmaEvents.lon = svmaEvents.lon(svmaIdx);
% Biggest shared SACV/SVMA quake
svmaDist = distance(svmaLat, svmaLon, svmaEvents.lat, svmaEvents.lon);
sacvDist = distance(sacvLat, sacvLon, sacvEvents.lat, sacvEvents.lon);
% shareDist = [svmaDist sacvDist];
svmaID = find(svmaDist > 30 & svmaDist < 90);
for i = length(svmaID):-1:1
    ID = svmaID(i);
    theDate = svmaEvents.time(ID);
    theDate = extractBetween(theDate, 1, 15);
    theMatch = regexp(sacvEvents.time, regexptranslate('wildcard',sprintf('%s*', theDate)));
    sacvID = find(cellfun(@isempty, theMatch) == 0);
    startTime = sacvEvents.time(sacvID);
    endTime = datetime(startTime) + minutes(30);
    endTime = datestr(endTime, 'yyyy-mm-dd HH:MM:SS.FFF');
    try
        sacvTraceIn = irisFetch.Traces('II','SACV','10','BH*', startTime, endTime);
        svmaTraceIn = irisFetch.Traces('AF','SVMA','','BH*', startTime, endTime); 
        i
    catch
    end
%     ensure 3 components exist
    if (length(sacvTraceIn) >= 2 ) && (length(svmaTraceIn) >= 2)
        mag = svmaEvents.mag(ID)
        dep = svmaEvents.depth(ID)
        coords = [svmaEvents.lat(ID) convertLon(svmaEvents.lon(ID),'-180to360')]
        shareDist = [svmaDist(ID) distance(sacvLat, sacvLon, coords(1), coords(2))];
        return
    end
end
end