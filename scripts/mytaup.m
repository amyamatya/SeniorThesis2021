function [datFinal] = mytaup(staLat,staLon, evLat, evLon, evDepth, phase)
% mytaup.m: return travel times using IRIS web service
% Last edit aamatya 12/2Z/20
% staLat = 14.97, staLon = -23.61;

% build URL using inputs, returning all phases unless specified
if ~exist('phase','var')
    url = sprintf('http://service.iris.edu/irisws/traveltime/1/query?model=prem&staloc=[%f,%f]&evloc=[%f,%f]&evdepth=%f',staLat, staLon, evLat, evLon, evDepth);
else
    url = sprintf('http://service.iris.edu/irisws/traveltime/1/query?model=prem&staloc=[%f,%f]&evloc=[%f,%f]&evdepth=%f&phases=%s',staLat, staLon, evLat, evLon, evDepth, phase);
end

% store and resize URL outputs
dat = urlread(url);
if isempty(dat)
    error('Search came up empty.');
end
dat = strsplit(dat);
first = find(contains(dat, '-----'));
dat = dat(first+1:end-1);
dat(find(contains(dat, '='))) = [];
for i = 1:(length(dat)/9)
    rowStart = 9*(i-1) + 1;
    datFinal(i,:) = dat(rowStart:rowStart+8);
end
datFinal = string(datFinal);
end

