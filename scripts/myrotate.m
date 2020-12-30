function [rad, trans, vert] = myrotate(startT, endT, azim)
% myrotate.m: rotate using IRIS web service
% Last edit aamatya 12/29/20
% build URL using inputs, put into data folder

url = sprintf('https://service.iris.edu/irisws/rotation/1/query?net=II&sta=SACV&loc=00&chaset=BH&starttime=%s&endtime=%s&components=ZRT&azimuth=%f&correct=none&output=sacbl&nodata=404',startT, endT, azim);
websave('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip', url); 
a = unzip('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip');
delete('/Users/aamatya/Documents/MATLAB/ST2021/files/poop.zip')
% datFinal = [radial transverse vertical]
rad = char(a(contains(a, 'BHR')));
trans = char(a(contains(a, 'BHT')));
vert = char(a(contains(a, 'BHZ')));
end

