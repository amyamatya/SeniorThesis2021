function [long] = convertLon(long,type)
% Convert longitude coordinates between [0 360] and [-180 180]
%---------Input Variables---------------------------
% long              - longitude
% type              - conversion ('360to-180' or '-180to360')
%---------------------------------------------------
if type == '360to-180'
    b = find(long > 180);
    long(b) = long(b) - 360;
elseif type == '-180to360'
    b = find(long < 0);
    long(b) = long(b) + 360;
end
end