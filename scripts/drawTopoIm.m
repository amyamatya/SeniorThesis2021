function [fig,ax] = drawTopoIm(xLim, yLim)
% Convert topo image to map axes for multi colorbar plotting
% last modified 2/17/21 @aamatya
%---------Input Variables---------------------------
% xLim, yLim      - (optional [min max]) new map axes
%                   image is cropped to default axes dfAx
%---------------------------------------------------
sacvLat = 14.97;
sacvLon = convertLon(-23.608, '-180to360');
% Load topo image
img = imread('/Users/aamatya/Documents/MATLAB/ST2021/figures/topo.tif');
img = imcrop(img, [151 115 906 615]);
img = flip(img, 1);
% Convert from image to geo coordinates
hold on
dfAx = [-80 80 sacvLon-155 abs(155-(360 - sacvLon))];
ax1 = worldmap(dfAx(1:2),dfAx(3:4));
R = maprefcells(xlim,ylim,size(img(:,:,1)));
ax2 = worldmap(xLim, yLim);
fig = mapshow(img,R);
ax = gca;
setm(ax, 'MlabelParallel', 'south');
hold off
end