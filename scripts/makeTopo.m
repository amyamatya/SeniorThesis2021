function [topoLat, topoLon, topoZ] = makeTopo(thePath)
% Load and store global relief data from the NOAA ETOPO1 Global Relief Model
% Output latitude, longitude, elevation to directory specified by thePath

%---Input Variables---------------
% thePath   - optional path to desired location of topographic .mat file

%---Output Variables---------------
% topoLat   - relief latitudes
% topoLon   - relief longitudes
% topoZ     - relief elevations

temp = websave('temp.gz','https://www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/ice_surface/grid_registered/netcdf/ETOPO1_Ice_g_gmt4.grd.gz');
temp = gunzip(temp);
[topoLatOld, topoLonOld, topoZOld] = grdread2(string(temp));
[lats, lons] = size(topoZOld);
topoLatOld = convertLon(topoLatOld, '-180to360');
topoLat = repmat(topoLatOld, lats, 1);
topoLon = repmat(topoLonOld', 1, lons);
topoLat = topoLat(:); 
topoLon = topoLon(:); 
topoZ = double(topoZOld(:));
if exist('thePath','var')
    save(sprintf('%s/topoData',path),'topoLat','topoLon','topoZ');
end
delete('temp.gz','temp');
end

