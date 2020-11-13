%% Scaled map
% Run figure01 and figure02 first
% Indices of nonzero depth
% report # of airquakes
depthIds = find(quakes.depth > 0);

% By magnitude
close all
figure(3)
subplot(2,1,1)
hold on
worldmap([-60 70],[230 90]);
geoshow(topo60c,topo60cR,'DisplayType','texturemap')
colormap(winter);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',.4);
scatterm(quakes.lat(depthIds), quakes.lon(depthIds), quakes.mag(depthIds),'wo','linewidth',0.01);
scatterm(14.97, convertLon(-23.608, '-180to360'), 20, 'filled','ro');
title('Quakes by Magnitude');
xlabel('Latitude');
ylabel('Longitude');
hold off

% By depth
subplot(2,1,2)
hold on
worldmap([-60 70],[230 90]);
geoshow(topo60c,topo60cR,'DisplayType','texturemap')
colormap(winter);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',.4);
scatterm(quakes.lat(depthIds), quakes.lon(depthIds), quakes.depth(depthIds),'wo','linewidth',0.01);
scatterm(14.97, convertLon(-23.608, '-180to360'), 20, 'filled','ro');
title('Quakes by Depth');
xlabel('Latitude');
ylabel('Longitude');
hold off

figure,
plot(quakes.lat(depthIds), quakes.lon(depthIds))



