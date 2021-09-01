function [rad, trans, vert] = myrotate(station, startT, location, endT, azim, components)
% Return rotated sacfile directory using IRIS web service
% Last edit 2/17/21 @aamatya
%---------Input variables------------------------------------
% station           - 'SACV' or 'SVMA'
% startT, endT      - (datenum format) times output by Trace
% azim              - event-station azimuth
% components        - available components (ex. 'ZR', 'ZRT')
%------------------------------------------------------------
% build URL using inputs
startT = datestr(startT, 'yyyy-mm-ddTHH:MM:SS');
endT = datestr(endT, 'yyyy-mm-ddTHH:MM:SS');
if strcmp(station, 'SACV')
url = sprintf('https://service.iris.edu/irisws/rotation/1/query?net=II&sta=SACV&loc=%s&chaset=BH&starttime=%s&endtime=%s&components=%s&azimuth=%f&correct=none&output=sacbl&nodata=404',location, startT, endT, components, azim);
else
    url = sprintf('https://service.iris.edu/irisws/rotation/1/query?net=AF&sta=SVMA&loc=--&chaset=BH&starttime=%s&endtime=%s&components=%s&azimuth=%f&correct=none&output=sacbl&nodata=404',startT, endT, components, azim);
end
websave('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip', url); 
a = unzip('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip');
delete('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip')
% Organize components
radFile = char(a(contains(a, 'BHR') | contains(a, 'BHN') | contains(a, 'BH1')));
transFile = char(a(contains(a, 'BHT') | contains(a, 'BHE') | contains(a, 'BH2')));
vertFile = char(a(contains(a, 'BHZ')));
% output data
rad = readsac(radFile);
trans = readsac(transFile);
vert = readsac(vertFile);
end