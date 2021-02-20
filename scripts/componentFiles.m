function [theRF, theRad, theTrans, theVert] = componentFiles(network, station, locatn, channel, fName, startT, endT, minMag, maxMag)
% Save receiver functions, components, and PZ files to new folder
%---------Input Variables------------------------------------
% network               - 'II' or 'AF'
% station               - 'SACV' or 'SVMA'
% locatn                - Iris location code ('00','10','')
% channel               - 'BH*'
% fName                 - destinnation path for RFs
% *T, *Mag              - query times and magnitudes
%---------Ouput Variables------------------------------------
% theRF                 - receiver function calculated by @aburky
% theRad, theTrans,    
% theVert               - component data (nx1 array)
%------------------------------------------------------------
% Make destination folder
sacDir = fullfile('~/Documents/MATLAB/ST2021/', fName);
if ~(exist(sacDir, 'dir'))
    mkdir(sacDir)
else 
    rmdir(sacDir,'s')
    mkdir(sacDir)
end
myFetchRFQuakes(network, station, locatn, channel, fullfile(sacDir,'/'), minMag, maxMag, startT, endT);
fileNames = dir(sacDir);
fileNames = string({fileNames.name});
% Get components
rMatch = regexp(fileNames, regexptranslate('wildcard','*.BH1*'));
if isempty([rMatch{:}])
    rMatch = regexp(fileNames, regexptranslate('wildcard','*.BHN*'));
end
tMatch = regexp(fileNames, regexptranslate('wildcard','*.BH2*'));
if isempty([tMatch{:}])
    tMatch = regexp(fileNames, regexptranslate('wildcard','*.BHE*'));
end
zMatch = regexp(fileNames, regexptranslate('wildcard','*.BHZ*'));
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
if strcmp(locatn, '10')
    copyfile('~/Documents/MATLAB/ST2021/ten/SAC_PZ*/', fullfile(sacDir,'/'));
elseif isempty(locatn)
    copyfile('~/Documents/MATLAB/ST2021/svma/SAC_PZ*/', fullfile(sacDir,'/'));
else
    copyfile('~/Documents/MATLAB/ST2021/data/SAC_PZ*', fullfile(sacDir,'/'));
end
[theRad, theTrans, theVert] = myComputeRFs(sacDir, rfDir, rad, trans, vert, locatn);
list = dir(fullfile(sacDir, 'RFs'));
theRF = readsac(fullfile(rfDir, list(end).name));
end