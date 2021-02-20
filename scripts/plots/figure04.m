%% Scaled map of magnitudes/depths
% Last modified 2/14/21 by aamatya@princeton.edu
%---------------------------------------------------------------
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
load allSacvEvents.mat;
% Report airquakes
airStr = sprintf('%d airquakes in donut, %d airquakes outside donut',...
    length(find(sacvEvents.depth < 0)),...
    length(find(sacvEventsOut.depth < 0)));
% Filter out airquakes
depthID = find(sacvEvents.depth > 0 & sacvEvents.mag > 5.5);
depthIDOut = find(sacvEventsOut.depth > 0 & sacvEventsOut.mag > 5.5);
theLats = sacvEvents.lat(depthID);
theLons = sacvEvents.lon(depthID);
theDepths = sacvEvents.depth(depthID);
theMags = sacvEvents.mag(depthID);
theLatsOut = sacvEventsOut.lat(depthIDOut);
theLonsOut = sacvEventsOut.lon(depthIDOut);
theDepthsOut = sacvEventsOut.depth(depthIDOut);
theMagsOut = sacvEventsOut.mag(depthIDOut);
% Place in ascending depth order for plotting
depthLats = [theLats;theLatsOut];
depthLons = [theLons;theLonsOut];
depthDepths = [theDepths; theDepthsOut];
[~, idx] = sort(depthDepths, 'ascend');
depthLats = depthLats(idx);
depthLons = depthLons(idx);
depthDepths = depthDepths(idx);
% Draw map scaled by depth
t = tiledlayout(2,1,'tilespacing','compact');
nexttile;
drawTopoIm([-80 80],[sacvLon-155 abs(155-(360 - sacvLon))]);
hold on
[h1, circLat1, circLon1] = circlem(sacvLat, sacvLon, deg2km(90),'edgecolor','none');
[h2, circLat2, circLon2]= circlem(sacvLat, sacvLon, deg2km(30),'edgecolor','none');
patchm(flip(circLat1), flip(circLon1), 'k','facealpha',0.3);
patchm(flip(circLat2), flip(circLon2), 'k','facealpha',0.3);
scatterm(depthLats, depthLons, 50, depthDepths,'.');
colormap(autumn); 
cb1 = colorbar;
mlabel('off');
scatterm(sacvLat, sacvLon, 25,'w*');
title(sprintf('Scaled By Depth (m) (%0.2f - %i) n = %d', min(depthDepths), max(depthDepths),...
    length(depthDepths)));
hold off
% Constrain magnitudes to interest (5.5)
idx = find(theMags > 5.5);
theLats = theLats(idx); 
theLons = theLons(idx); 
theDepths = theDepths(idx);
theMags = theMags(idx);
idx = find(theMagsOut > 5.5);
theLatsOut = theLatsOut(idx); 
theLonsOut = theLonsOut(idx); 
theDepthsOut = theDepthsOut(idx);
theMagsOut = theMagsOut(idx);
% Place in ascending magnitude order for plotting
magLats = [theLats;theLatsOut];
magLons = [theLons;theLonsOut];
magMags = [theMags; theMagsOut];
[~, idx] = sort(magMags, 'ascend');
magLats = magLats(idx);
magLons = magLons(idx);
magMags = magMags(idx);
% Draw map scaled by magnitude
nexttile;
drawTopoIm([-80 80],[sacvLon-155 abs(155-(360 - sacvLon))]);
hold on
[h1, circLat1, circLon1] = circlem(sacvLat, sacvLon, deg2km(90),'edgecolor','none');
[h2, circLat2, circLon2]= circlem(sacvLat, sacvLon, deg2km(30),'edgecolor','none');
patchm(flip(circLat1), flip(circLon1), 'k','facealpha',0.3);
patchm(flip(circLat2), flip(circLon2), 'k','facealpha',0.3);
scatterm(magLats, magLons, 50, magMags,'.');
colormap(autumn); 
cb2 = colorbar;
title(sprintf('Scaled By Magnitude (5.5 - 9) n = %d', length(magMags)));
scatterm(sacvLat, sacvLon,25,'w*');
hold off
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure04','-fillpage','-dpdf');