% Run figure05.m first

drawTopoIm([-80 80],[180 130]);
hold on
in = scatterm(sacvEvents.lat(sacvID), sacvEvents.lon(sacvID), 200, 'y*','linewidth',2);
out = scatterm(sacvEvents.lat(sacvIDOut), sacvEvents.lon(sacvIDOut), 200, 'r*','linewidth',2);
[h1, circLat1, circLon1] = circlem(sacvLat, sacvLon, deg2km(90),'edgecolor','none');
[h2, circLat2, circLon2]= circlem(sacvLat, sacvLon, deg2km(30),'edgecolor','none');
patchm(flip(circLat1), flip(circLon1), 'k','facealpha',0.3);
patchm(flip(circLat2), flip(circLon2), 'k','facealpha',0.3);
scatterm(sacvLat, sacvLon, 15,'filled','wo');
[lgnd, obj] = legend([in out], sprintf('%s',extractBetween(sacvEvents.time(sacvID), 1, 16)),...
    sprintf('%s',extractBetween(sacvEvents.time(sacvIDOut), 1, 16)),'location','southwest');
set(lgnd.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1;1;1;0.7]));
lgnd.Location = 'southwest';
objhl = findobj(obj, 'type', 'Patch');
set(objhl, 'Markersize', 10);
set(objhl, 'linewidth', 1);
hold off