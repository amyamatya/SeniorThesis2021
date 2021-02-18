function backAzimuth = backAzim(azim)
% Calculate backazimuth from azimuth
if azim < 180
    backAzimuth = azim + 180;
else
    backAzimuth = azim - 180;
end

