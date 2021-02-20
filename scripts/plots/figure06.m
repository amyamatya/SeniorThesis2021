% figure06: comparison shallow-small, shallow-large, deep-large event worldmap
% last edit 2/18/21 @aammmatya
%------------------------------------------------------------------------
% Get traces and RFs
[ssRF, ssRad, ssTrans, ssVert, ssCords, ssDepth, ssMag, ssStart, ssEnd] = sizeDepth(5.499, 5.50, 0.1, 4, 'smallShallow');
[bsRF, bsRad, bsTrans, bsVert, bsCords, bsDepth, bsMag, bsStart, bsEnd] = sizeDepth(8.3, 9, 0.1, 4, 'bigShallow');
[bdRF, bdRad, bdTrans, bdVert, bdCords, bdDepth, bdMag, bdStart, bdEnd] = sizeDepth(7, 9, 150, 800, 'bigDeep');
%%
% Plot seismograms onto worldmap
clf
figure(1)
sacvLat = 14.97; sacvLon = -23.608;
[~,ax] = drawTopoIm([-80 80],[180 130]);
hold on
[h1, circLat1, circLon1] = circlem(sacvLat, sacvLon, deg2km(90),'edgecolor','none');
[h2, circLat2, circLon2]= circlem(sacvLat, sacvLon, deg2km(30),'edgecolor','none');
patchm(flip(circLat1), flip(circLon1), 'k','facealpha',0.3);
patchm(flip(circLat2), flip(circLon2), 'k','facealpha',0.3);
scatterm(sacvLat, sacvLon, 50, 'w*');
s1 = scatterm(ssCords(1), convertLon(ssCords(2),'360to-180'), 50, 'r*','linewidth',2);
s2 = scatterm(bsCords(1), convertLon(bsCords(2),'360to-180'), 50, [1 0.5 0.5],'*','linewidth',2);
s3 = scatterm(bdCords(1), convertLon(bdCords(2),'360to-180'), 50, 'y*','linewidth',2);
ax = gca;
% Small-shallow
ax1 = axes('Position',[ax.Position(1)+0.4 ax.Position(2)+0.64 ax.Position(3)-0.40 ax.Position(4)-0.77]);
plot(ssRad);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
xlim([0 length(ssRad)]);
axes('Position',[ax1.Position(1) ax1.Position(2)-0.05 ax1.Position(3) ax1.Position(4)]);
plot(ssTrans);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
xlim([0 length(ssRad)]);
axes('Position',[ax1.Position(1) ax1.Position(2)-0.1 ax1.Position(3) ax1.Position(4)]);
plot(ssVert);
set(gca, 'yticklabels',[]);
xlim([0 length(ssRad)]);
annotation('line',[ax1.Position(1) ax1.Position(1)+0.35],[ax1.Position(2)-0.1 ax1.Position(2)-0.15],'Color','r');
% Large-shallow
ax2 = axes('Position',[ax.Position(1)+0.49 ax.Position(2)+0.44 ax.Position(3)-0.4 ax.Position(4)-0.77]);
plot(bsRad);
xlim([0 length(bsRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
axes('Position',[ax2.Position(1) ax2.Position(2)-0.05 ax2.Position(3) ax1.Position(4)]);
plot(bsTrans);
xlim([0 length(bsRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
axes('Position',[ax2.Position(1) ax2.Position(2)-0.1 ax2.Position(3) ax2.Position(4)]);
plot(bsVert);
xlim([0 length(bsRad)]);
set(gca, 'yticklabels',[]);
% Large-deep
ax3 = axes('Position',[ax.Position(1)+0.4 ax.Position(2)+0.24 ax.Position(3)-0.4 ax.Position(4)-0.77]);
plot(bdRad);
xlim([0 length(bdRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
axes('Position',[ax3.Position(1) ax3.Position(2)-0.05 ax3.Position(3) ax3.Position(4)]);
plot(bdTrans);
xlim([0 length(bdRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
axes('Position',[ax3.Position(1) ax3.Position(2)-0.1 ax3.Position(3) ax3.Position(4)]);
plot(bdVert);
xlim([0 length(bdRad)]);
set(gca, 'yticklabels',[]);
hold off
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure06','-fillpage','-dpdf');

% calculate travel times
[timeTable, url] = mytaup(ssCords(1), convertLon(ssCords(2),'360to-180'), ssDepth);
datestr(ssStart, 'yyyy-mm-ddTHH:MM:SS');
sampRate = length(ssRad)/eIristime(startT, endT);
hold on
[row, col] = find(strcmp(timeTable, 'P'));
pArriv = str2num(timeTable(row(1),4));
[row, col] = find(strcmp(timeTable, 'S'));
sArriv = str2num(timeTable(row(1),4));
% Plot particle motions
close all
figure(1)
titl(1) = parcleMotn(ssRad, ssTrans, ssVert, pArriv, sArriv, sampRate, 1000, 1000);
titl(1).String = 'Small-Shallow';
figure(2)
titl(2) = parcleMotn(bsRad, bsTrans, bsVert, pArriv, sArriv, sampRate, 1000, 1000);
titl(2).String = 'Large-Shallow';
figure(3)
titl(3) = parcleMotn(bdRad, bdTrans, bdVert, pArriv, sArriv, sampRate, 1000, 1000);
titl(3).String = 'Small-Deep';






