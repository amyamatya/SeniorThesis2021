function [fig] = drawTopo()
% Plot a worldmap with bathymetry, plate boundaries, and SACV station
% Last modified 2/12/21 @aamatya
clf
% Station coordinates
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
% Plate boundaries
plateKml = unzip('plate-boundaries.kmz');
[pbxOld, pby, pbz] = read_kml(string(plateKml(4)));
errs = find(pbz ~= 0);
pbxOld(errs) = []; pby(errs) = []; pbz(errs) = [];
pbx = convertLon(pbxOld, '-180to360');
% Topography
[topoLat, topoLon, topoZ] = makeTopo();
% Shorelines
filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1})
levels = [shorelines.Level];
land = (levels == 1);  
% Show worldmap
clf
hold on
ax = worldmap([-90 90],[160 159]);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',0);
scatterm(topoLon(1:20:end), topoLat(1:20:end),1, topoZ(1:20:end));
demcmap([min(topoZ) max(topoZ)]);
colorbar
scatterm(pby, pbx, 0.06, pbz); %'w.');
scatterm(sacvLat, sacvLon, 10,'filled','ro');
textm(sacvLat + 10, sacvLon - 10, 'CV','Color','r');
axis image
setm(ax, 'MlabelParallel', 'south');
hold off
delete('usgs.jpg','PlateMotionLegend.png','doc.kml','arrow.png');
fig = gcf;
end








