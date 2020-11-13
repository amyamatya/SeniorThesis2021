%% Introductory map: plate boundaries, SACV station

% Load map, topography, plate boundaries
filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1})
levels = [shorelines.Level];
land = (levels == 1);  
load topo60c
[pbxOld, pby, pbz] = read_kml('plate-boundaries.kml');
% Filter and convert invalid plate boundary coordinates
errs = find(pbz ~= 0);
pbxOld(errs) = []; pby(errs) = []; pbz(errs) = [];
pbx = convertLon(pbxOld, '-180to360');
% Store SACV coordinates
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
% Set up worldmap
close all
figure(1)
hold on
ax = worldmap([-90 90],[160 159]);
geoshow(topo60c,topo60cR,'DisplayType','texturemap');
colormap(winter);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',0);
title('SACV Station');
xlabel('Latitude');
ylabel('Longitude');
setm(ax,'mlabelparallel',-90);
% Plot data
scatterm(pby, pbx,'w.');
scatterm(sacvLat, sacvLon ,20, 'filled','ro');
text(350, convertLon(360, '-180to360'), 'SACV Station','color','r');
hold off
axis image
print(figure(1), '/Users/aamatya/Documents/MATLAB/Figures/figure01','-dpdf');
% Clean workspace
clearvars -except filename shorelines levels land 


