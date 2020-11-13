%% Scaled map
% Last modified 11/12/2020 by aamatya@princeton.edu

% Run figure01 and figure02 first
% Indices of nonzero depth
% report # of airquakes (580 for all, 50 for donut)
donutDepthid1 = find(donutQuakes1.depth > 0);
allDepthid = find(allQuakes.depth > 0);
allAirquakes = length(find(allQuakes.depth < 0));
donutDepthid2 = find(donutQuakes2.depth > 0);
donutAirquakes = length(find(donutQuakes2.depth < 0));

% By magnitude
close all
figure(3)
subplot(2,1,1)
hold on
ax = worldmap([-90 90],[160 159]);
geoshow(topo60c,topo60cR,'DisplayType','texturemap')
colormap(winter);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',.4);
sc1 = scatterm(allQuakes.lat(allDepthid), allQuakes.lon(allDepthid), allQuakes.mag(allDepthid),'mo','linewidth',0.001);
sc2 = scatterm(donutQuakes2.lat(donutDepthid2), donutQuakes2.lon(donutDepthid2), donutQuakes2.mag(donutDepthid2),'co','linewidth',0.001);
scatterm(14.97, convertLon(-23.608, '-180to360'), 20, 'filled','ro');
setm(ax,'mlabelparallel',-90);
legend([sc1 sc2],'All quakes','Donut quakes','Location','southeast');
title('Quakes by Magnitude');
xlabel('Latitude');
ylabel('Longitude');
hold off

% By depth
subplot(2,1,2)
hold on
ax = worldmap([-90 90],[160 159]);
geoshow(topo60c,topo60cR,'DisplayType','texturemap')
colormap(winter);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',.4);
sc1 = scatterm(allQuakes.lat(allDepthid), allQuakes.lon(allDepthid), allQuakes.depth(allDepthid),'mo','linewidth',0.001);
sc2 = scatterm(donutQuakes2.lat(donutDepthid2), donutQuakes2.lon(donutDepthid2), donutQuakes2.depth(donutDepthid2),'co','linewidth',0.001);
scatterm(14.97, convertLon(-23.608, '-180to360'), 20, 'filled','ro');
setm(ax,'mlabelparallel',-90);
title('Quakes by Depth');
xlabel('Latitude');
ylabel('Longitude');
hold off

set(gcf, 'PaperSize',[5 7]);

print(figure(3), '/Users/aamatya/Desktop/Thesis/Figures/figure03','-dpdf','-fillpage');


