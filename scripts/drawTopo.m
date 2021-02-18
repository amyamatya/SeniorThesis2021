function [fig, varargout] = drawTopo(bound)
% Draw a worldmap with relief and plate boundaries
% Plate boundary source: http://www-udc.ig.utexas.edu/external/plates/data.htm
% Last modified 2/12/21 @aamatya

%---Input variables------------
% bound     - 1 = boundaries colored by type
%           - 2 = all boundaries white
%           - 3 = return boundaries to overlay on external data
%           - default = no boundaries
%---Output variables------------
% fig       - figure handle
% var       - optional returns of plate boundary data [lat lon]
%               - 1 = divergent
%               - 2 = convergent
%               - 3 = transform

% Load Cape Verde coordinates
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
% Load plate boundaries
if exist('bound','var')
    div = shaperead('ridge.shp');
    divLon = [div.X]; divLat = [div.Y];
    divLon(isnan(divLon)) = []; divLat(isnan(divLat)) = [];
    conv = shaperead('trench.shp');
    convLon = [conv.X]; convLat = [conv.Y];
    convLon(isnan(convLon)) = []; convLat(isnan(convLat)) = [];
    trans = shaperead('transform.shp');
    transLon = [trans.X]; transLat = [trans.Y];
    transLon(isnan(transLon)) = []; transLat(isnan(transLat)) = [];
end
% Load topography
[topoLat, topoLon, topoZ] = makeTopo();
% Load shorelines
filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1})
levels = [shorelines.Level];
land = (levels == 1);
% Show on worldmap
clf
hold on
ax = worldmap([-80 80],[sacvLon - 155 abs(155-(360 - sacvLon))]);
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',0);
scatterm(topoLon(1:20:end), topoLat(1:20:end),1, topoZ(1:20:end));
demcmap([min(topoZ) max(topoZ)]);
if exist('bound','var')
    if bound == 1
        div = scatterm(divLat, divLon, 1, 'r.');
        conv = scatterm(convLat, convLon, 1, 'y.');
        trans = scatterm(transLat, transLon, 1, rgb('LightPink'),'.');
        [lgnd,obj] = legend([div conv trans], 'Divergent','Convergent',...
            'Transform','location','southeast');
        set(lgnd.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[.5;.5;.5;.5]));
        objhl = findobj(obj, 'type', 'Patch');
        set(objhl, 'Markersize', 15);
    elseif bound == 2
        scatterm([divLat convLat transLat], [divLon convLon transLon], 1, 'w.');
    elseif bound == 3
        varargout{1} = [divLat;divLon]';
        varargout{2} = [convLat;convLon]';
        varargout{3} = [transLat;transLon]';
    end
end
% scatterm(sacvLat, sacvLon, 10,'filled','wo');
% textm(sacvLat + 10, sacvLon - 10, 'CV','Color','w');
axis image
setm(ax, 'MlabelParallel', 'south');
hold off
fig = gcf;
end
% Alternative: USGS plate boundaries
% plateKml = unzip('plate-boundaries.kmz');
% [pbxOld, pby, pbz] = read_kml(string(plateKml(4)));
% errs = find(pbz ~= 0);
% pbxOld(errs) = []; pby(errs) = []; pbz(errs) = [];
% pbx = convertLon(pbxOld, '-180to360');
% scatterm(pby, pbx, 0.06, pbz); %'w.');
% delete('usgs.jpg','PlateMotionLegend.png','doc.kml','arrow.png');