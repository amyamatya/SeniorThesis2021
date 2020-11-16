%% figure01: Map of geographic/tectonic context
% Last modified 11/15/2020 by aamatya@princeton.edu
%% 1 - Load, reconfigure, save topographic relief data
% Skip to section 2 if ran startup.m
% Data: ETOPO1 Ice Surface from https://www.ngdc.noaa.gov/mgg/global/global.html
[topoxOld, topoyOld, topozOld] = grdread2('ETOPO1_Ice_g_gdal.grd');
[lats, lons] = size(topozOld);
topoxOld = convertLon(topoxOld, '-180to360');
topox = repmat(topoxOld, lats, 1);
topoy = repmat(topoyOld', 1, lons);
topox = topox(:); topoy = topoy(:); topoz = double(topozOld(:));
clear topoxOld topoyOld topozOld lats lons
%% 2 - Load other geographic data
% Load shorelines
filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1})
levels = [shorelines.Level];
land = (levels == 1);  
% load topo60c
% Load and filter plate boundaries
[pbxOld, pby, pbz] = read_kml('plate-boundaries.kml');
errs = find(pbz ~= 0);
pbxOld(errs) = []; pby(errs) = []; pbz(errs) = [];
pbx = convertLon(pbxOld, '-180to360');
% Store SACV coordinates
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
%% Plot map
close all
figure(1)
hold on
ax = worldmap([-90 90],[160 159]);
% geoshow(topo60c,topo60cR,'DisplayType','texturemap');
% colormap(winter);
scatterm(topoy(1:10:end), topox(1:10:end),1, topoz(1:10:end));
demcmap([min(topoz) max(topoz)]);

geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',0);
title('SACV Seismic Context');
xlabel('Latitude');
ylabel('Longitude');
setm(ax,'mlabelparallel',-90);
% Plot data
plates = scatterm(pby, pbx, 0.06, 'w.');

scatterm(sacvLat, sacvLon ,20, 'filled','ro');
annotation('textbox',[.5 .57 .07 .04],'String','SACV','edgecolor','r','color','r');
hold off
axis image
% print(figure(1), '/Users/aamatya/Desktop/Thesis/Figures/figure01','-dpdf');

% Clean workspace
% test push
