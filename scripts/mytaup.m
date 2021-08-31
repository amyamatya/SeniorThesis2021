function [datFinal, url] = mytaup(evLat, evLon, evDepth, phase)
% Return travel times using IRIS web service
% Last edit 2/17/21 @aamatya
%---------Input Variables---------------------------
% evLat, evLon, evDepth     - event info
% phase                     - optional: query phase
%---------Output Variables--------------------------
% datFinal                  - string table of arrival times
% url                       - retrieval url for IRIS webservice
%---------------------------------------------------

staLat = 14.97; staLon = -23.608;
% build URL using inputs, returning all phases unless specified
if ~exist('phase','var')
    url = sprintf('http://service.iris.edu/irisws/traveltime/1/query?model=iasp91&staloc=[%f,%f]&evloc=[%f,%f]&evdepth=%f',staLat, staLon, evLat, evLon, evDepth);
else
    url = sprintf('http://service.iris.edu/irisws/traveltime/1/query?model=iasp91&staloc=[%f,%f]&evloc=[%f,%f]&evdepth=%f&phases=%s',staLat, staLon, evLat, evLon, evDepth, phase);
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