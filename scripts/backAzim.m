function backAzimuth = backAzim(azim)
% Calculate backazimuth given azimuth
% Last modified 2/17/21 @aamatya
%------------------------------------------------------
if azim < 180
    backAzimuth = azim + 180;
else
    backAzimuth = azim - 180;
end