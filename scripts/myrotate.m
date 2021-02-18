function [rad, trans, vert, radFile, transFile, vertFile] = myrotate(startT, endT, azim)
% myrotate.m: return rotated sacfile directory using IRIS web service
% Last edit aamatya 1/13/21

% build URL using inputs
url = sprintf('https://service.iris.edu/irisws/rotation/1/query?net=II&sta=SACV&loc=00&chaset=BH&starttime=%s&endtime=%s&components=ZRT&azimuth=%f&correct=none&output=sacbl&nodata=404',startT, endT, azim);
websave('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip', url); 
a = unzip('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip');
delete('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip')
radFile = char(a(contains(a, 'BHR')));
transFile = char(a(contains(a, 'BHT')));
vertFile = char(a(contains(a, 'BHZ')));
% output data
rad = readsac(radFile);
trans = readsac(transFile);
vert = readsac(vertFile);
% poop = fullfile(string(extractBetween(char(a(1)), 1, "/meta")));
% rmdir(poop);
end

