function [fig] = drawPlates()
% Draw a worldmap with labelled plates
% Source: http://geoscience.wisc.edu/~chuck/MORVEL/PltBoundaries.html 
% (Bird (2003) and Argus et al. (2011))
% Last modified 2/12/21 @aamatya
%---------------------------------------------------------------
% Store Cape Verde
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
% Load shorelines
filename = gunzip('gshhs_c.b.gz', tempdir);
shorelines = gshhs(filename{1});
delete(filename{1})
levels = [shorelines.Level];
land = (levels == 1);
% Load pretty colors
colors = [rgb('LightGrey');rgb('Goldenrod');rgb('Honeydew');rgb('LightSlateGray');...
    rgb('MediumOrchid');rgb('Amethyst');rgb('PeachPuff');rgb('SkyBlue');...
    rgb('BlanchedAlmond');rgb('Beige');rgb('LightSkyBlue');rgb('Tan');...
    rgb('MistyRose');rgb('LightYellow');rgb('RosyBrown');rgb('Cornsilk');...
    rgb('LightSteelBlue');rgb('LavenderBlush');rgb('PaleTurquoise');rgb('Thistle');...
    rgb('LightBlue');rgb('PowderBlue');rgb('Lavender');rgb('PaleVioletRed');...
    rgb('Linen'); rgb('Plum');rgb('PaleGoldenrod');rgb('PapayaWhip')];
% Load and show each plate
list = dir('/Users/aamatya/Documents/MATLAB/ST2021/files/NnrMRVL_PltBndsLatLon');
clf
ax = worldmap([-40 60],[sacvLon - 80 abs(80-(360 - sacvLon))]);
hold on
for i = 3:length(list)
    colorID = mod(i, 28);
    if colorID == 0
        colorID = 28;
    end
    theFile = importdata(list(i).name);
    boundLon = theFile.data(:,1);
    boundLat = theFile.data(:,2);
    patchm(boundLon, boundLat, colors(colorID,:));
    %     Label plates adjacent to Cape Verde
    if list(i).name == 'nu'
        textm(boundLat(1)-20, boundLon(1)+ 45, ['African', char(10), 'Plate'],'color',colors(colorID,:) - 0.2);
    elseif list(i).name == 'sa'
        textm(boundLat(1)-10, boundLon(1)- 8, ['South', char(10), 'American', char(10),'Plate'],...
            'color',colors(colorID,:) - 0.2);
    elseif list(i).name == 'BR' 
        textm(boundLat(1)-142, boundLon(1)-53, ['North', char(10), 'American', char(10),'Plate'],...
            'color',colors(colorID,:) - 0.2);
    elseif list(i).name == 'MN'
          textm(boundLat(1) - 107, boundLon(1)-22, ['Eurasian', char(10),'Plate'],...
            'color',colors(colorID,:) - 0.2);
    end    
end
% Show shorelines and Cape Verde
geoshow(shorelines(land), 'facecolor', [0.4 0.9 0.4],'facealpha',0);
plotm(sacvLat, convertLon(sacvLon, '360to-180'),'r.', 'markersize',10);
textm(sacvLat + 5, sacvLon - 2, 'CV','Color','r');
hold off
setm(ax, 'MlabelParallel', 'south');
fig = gcf;
end