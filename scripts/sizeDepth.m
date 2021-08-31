function [theRF, theRad, theTrans, theVert, theCords, theDepth, theMag, startT, endT] = sizeDepth(minMag, maxMag, minDepth, maxDepth, fName, locatn);
%------------Input Variables------------------------------
% minMag, maxMag        - query magnitudes
% minDepth, maxDepth    - query boundaries
% fName                 - unique name of destination folder
% locatn                - location code ('10','00','')
%------------Output Variables------------------------------
% theRF                 - receiver function (nx1 array)
% theRad                - rotated/transferred radial component (nx1 array)
% theTrans              - rotated/transferred transverse component (nx1 array)
% theVert               - rotated/transferred vertical component (nx1 array)
% theCords              - coordinates of first search hit [lat lon]
% theDepth              - depth of first search hit (m)
% theMag                - magnitude of first search hit
% startT, endT          - event start and end

% Find SACV event that meets boundary conditions
[~, sacvEvents] =  getEvents('SACV',30, 90, minMag, maxMag);
idx = find(sacvEvents.depth > minDepth & sacvEvents.depth < maxDepth);
theDepth = sacvEvents.depth(idx(1));
theMag = sacvEvents.mag(idx(1));
theCords = [sacvEvents.lat(idx(1)) sacvEvents.lon(idx(1))];
theEvents = sacvEvents.time(idx);
timeFormat = 'yyyy-mm-dd HH:MM:SS.FFF';
% Save event to new folder
sacDir = fullfile('~/Documents/MATLAB/ST2021/', fName);
if ~(exist(sacDir, 'dir'))
    mkdir(sacDir)
else 
    rmdir(sacDir,'s')
    mkdir(sacDir)
end
startT = theEvents(1);
endT = datestr(datenum(startT) + minutes(30), timeFormat);
startT = datestr(theEvents(1), timeFormat);
myFetchRFQuakes('II','SACV',locatn,'BH*',fullfile(sacDir,'/'), minMag, maxMag, startT, endT);
fileNames = dir(sacDir);
fileNames = string({fileNames.name});
% Get components
rMatch = regexp(fileNames, regexptranslate('wildcard',sprintf('*SACV.%s.BH1*',locatn)));
if isempty([rMatch{:}])
    rMatch = regexp(fileNames, regexptranslate('wildcard',sprintf('*SACV.%s.BHN*',locatn)));
end
tMatch = regexp(fileNames, regexptranslate('wildcard',sprintf('*SACV.%s.BH2*',locatn)));
if isempty([tMatch{:}])
    tMatch = regexp(fileNames, regexptranslate('wildcard',sprintf('*SACV.%s.BHE*',locatn)));
end
zMatch = regexp(fileNames, regexptranslate('wildcard',sprintf('*SACV.%s.BHZ*',locatn)));
for i = 1:length(rMatch)
    if rMatch{i} == 1
        rad = fileNames(i);
    end
    if tMatch{i} == 1
        trans = fileNames(i);
    end
    if zMatch{i} == 1
        vert = fileNames(i);
    end
end
rfDir = fullfile(sacDir, 'RFs');
rad = fullfile(sacDir, rad);
trans = fullfile(sacDir, trans);
vert = fullfile(sacDir, vert);
% Get transferred components and receiver function
copyfile('~/Documents/MATLAB/ST2021/allCVEvents/SAC_PZ*', fullfile(sacDir,'/'));
[theRad, theTrans, theVert] = myComputeRFs(sacDir, rfDir, rad, trans, vert, '00');
list = dir(fullfile(sacDir, 'RFs'));
theRF = readsac(fullfile(rfDir, list(end).name));
end