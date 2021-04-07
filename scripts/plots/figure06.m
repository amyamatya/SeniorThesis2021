% figure06: comparison shallow-small, shallow-large, deep-large event worldmap
%------------------------------------------------------------------------
% Get traces and RFs
[ssRF, ssRad, ssTrans, ssVert, ssCords, ssDepth, ssMag, ssStart, ssEnd] = sizeDepth(5.499, 5.50, 35, 40, 'smallShallow','10');
[bsRF, bsRad, bsTrans, bsVert, bsCords, bsDepth, bsMag, bsStart, bsEnd] = sizeDepth(7.3,8, 0.1, 50, 'bigShallow','10');
[bdRF, bdRad, bdTrans, bdVert, bdCords, bdDepth, bdMag, bdStart, bdEnd] = sizeDepth(7.5, 9, 150, 800, 'bigDeep','10');
%%

% Plot seismograms onto worldmap
clf
figure(1)
sacvLat = 14.97; sacvLon = -23.608;
[~,ax] = drawTopoIm([-80 80],[180 130], 0.5);
poop = gcf;
hold on
[h1, circLat1, circLon1] = circlem(sacvLat, sacvLon, deg2km(90),'edgecolor','none');
[h2, circLat2, circLon2]= circlem(sacvLat, sacvLon, deg2km(30),'edgecolor','none');
patchm(flip(circLat1), flip(circLon1), 'k','facealpha',0.3);
patchm(flip(circLat2), flip(circLon2), 'k','facealpha',0.3);
scatterm(sacvLat, sacvLon, 50, 'w*');
s1 = scatterm(ssCords(1), convertLon(ssCords(2),'360to-180'), 50, 'r*','linewidth',1);
s2 = scatterm(bdCords(1), convertLon(bsCords(2),'360to-180'), 50, rgb('DarkOrange'),'*','linewidth',1);
s3 = scatterm(bsCords(1), convertLon(bdCords(2),'360to-180'), 50, 'b*','linewidth',1);
[lgnd, objh] = legend([s1 s2 s3],'Small-Shallow','Large-Deep','Large-Shallow','location','northwest');
objhl = findobj(objh, 'type', 'patch'); 
set(objhl, 'Markersize', 10);
set(objhl, 'linewidth',1);
set(lgnd.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1;1;1;.8]));
ax = gca;


% Small-shallow
ax1 = axes('Position',[ax.Position(1)+0.4 ax.Position(2)+0.75 ax.Position(3)-0.45 ax.Position(4)-0.7]);
plot(ssRad,'Color', [0 0.2 0.4]);
set(gca, 'XColor',rgb('Red'));
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'FontWeight','bold');
set(gca, 'linewidth',1.5);
xlim([0 length(ssRad)]);
ylim([min(min([ssRad ssTrans ssVert])) max(max([ssRad ssTrans ssVert]))]);
axes('Position',[ax1.Position(1) ax1.Position(2)-0.1 ax1.Position(3) ax1.Position(4)]);
plot(ssTrans,'Color', rgb('SteelBlue'));
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'XColor',rgb('Red'));
set(gca, 'FontWeight','bold');
set(gca, 'linewidth',1.5);
xlim([0 length(ssRad)]);
ylim([min(min([ssRad ssTrans ssVert])) max(max([ssRad ssTrans ssVert]))]);
axes('Position',[ax1.Position(1) ax1.Position(2)-0.2 ax1.Position(3) ax1.Position(4)]);
plot(ssVert,'Color', rgb('LightSteelBlue'));
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'XColor',rgb('Red'));
set(gca, 'FontWeight','bold');
set(gca, 'linewidth',1.5);
xlim([0 length(ssRad)]);
ylim([min(min([ssRad ssTrans ssVert])) max(max([ssRad ssTrans ssVert]))]);
annotation('line',[ax1.Position(1)-0.14 ax1.Position(1)],[ax1.Position(2)-0.38 ax1.Position(2)+0.043],'Color',rgb('Red'),'linewidth',1.5);
annotation('line',[ax1.Position(1)-0.14 ax1.Position(1)],[ax1.Position(2)-0.38 ax1.Position(2)-0.1],'Color',rgb('Red'),'linewidth',1.5);


% Large-Deep
ax2 = axes('Position',[ax.Position(1)+0.49 ax.Position(2)+0.25 ax.Position(3)-0.45 ax.Position(4)-0.7]);
plot(bdRad,'Color', [0 0.2 0.4]);
xlim([0 length(bsRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'linewidth',1.5);
set(gca, 'FontWeight','bold');
set(gca, 'XColor',rgb('DarkOrange'));
ylim([min(min([bdRad bdTrans bdVert])) max(max([bdRad bdTrans bdVert]))]);
axes('Position',[ax2.Position(1) ax2.Position(2)-0.1 ax2.Position(3) ax1.Position(4)]);
plot(bdTrans,'Color',rgb('SteelBlue'));
xlim([0 length(bsRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'linewidth',1.5);
set(gca, 'FontWeight','bold');
set(gca, 'XColor',rgb('DarkOrange'));
ylim([min(min([bdRad bdTrans bdVert])) max(max([bdRad bdTrans bdVert]))]);
axes('Position',[ax2.Position(1) ax2.Position(2)-0.2 ax2.Position(3) ax2.Position(4)]);
plot(bdVert,'Color', rgb('LightSteelBlue'));
xlim([0 length(bsRad)]);
set(gca, 'yticklabels',[]);
set(gca, 'xticklabels',[]);
set(gca, 'XColor',rgb('DarkOrange'));
set(gca, 'FontWeight','bold');
set(gca, 'linewidth',1.5);
ylim([min(min([bdRad bdTrans bdVert])) max(max([bdRad bdTrans bdVert]))]);
annotation('line',[ax1.Position(1)-0.14 ax2.Position(1)],[ax1.Position(2)-0.38 ax2.Position(2)+0.043],'Color',rgb('Orange'),'linewidth',1.5);
annotation('line',[ax1.Position(1)-0.14 ax2.Position(1)],[ax1.Position(2)-0.38 ax2.Position(2)-0.1],'Color',rgb('Orange'),'linewidth',1.5);

% Large-Shallow
ax3 = axes('Position',[0 ax.Position(2)+0.4 ax.Position(3)-0.45 ax.Position(4)-0.7]);
plot(bsRad,'Color', [0 0.2 0.4]);
xlim([0 length(bdRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'XColor',rgb('Blue'));
set(gca, 'linewidth',1.5);
axes('Position',[ax3.Position(1) ax3.Position(2)-0.1 ax3.Position(3) ax3.Position(4)]);
plot(bsTrans,'Color', rgb('SteelBlue'));
xlim([0 length(bdRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'XColor',rgb('Blue'));
set(gca, 'linewidth',1.5);
axes('Position',[ax3.Position(1) ax3.Position(2)-0.2 ax3.Position(3) ax3.Position(4)]);
plot(bsVert,'Color', rgb('LightSteelBlue'));
xlim([0 length(bdRad)]);
set(gca, 'xticklabels',[]);
set(gca, 'yticklabels',[]);
set(gca, 'XColor', rgb('Blue'));
set(gca, 'linewidth',1.5);
set(gca, 'FontWeight','bold');
annotation('line',[ax3.Position(1)+0.405 ax3.Position(1)+0.325],[ax3.Position(2)-0.165 ax3.Position(2)-0.11],'Color','b','linewidth',1.5);
annotation('line',[ax3.Position(1)+0.405 ax3.Position(1)+0.325],[ax3.Position(2)-0.165 ax3.Position(2)+0.04],'Color','b','linewidth',1.5);
hold off
set(gcf, 'PaperSize',[10 7]);
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure06/figure01','-fillpage','-dpdf');
%%

% calculate travel times
[timeTable, ~] = mytaup(ssCords(1), convertLon(ssCords(2),'360to-180'), ssDepth);
startT = datestr(ssStart, 'yyyy-mm-ddTHH:MM:SS');
endT = datestr(ssEnd, 'yyyy-mm-ddTHH:MM:SS');
ssSampRate = length(ssRad)/eIristime(startT, endT);
[row, col] = find(strcmp(timeTable, 'P'));
ssPArriv = str2num(timeTable(row(1),4));
[row, col] = find(strcmp(timeTable, 'S'));
ssSArriv = str2num(timeTable(row(1),4));

[timeTable, ~] = mytaup(bsCords(1), convertLon(bsCords(2),'360to-180'), bsDepth);
startT = datestr(bsStart, 'yyyy-mm-ddTHH:MM:SS');
endT = datestr(bsEnd, 'yyyy-mm-ddTHH:MM:SS');
bsSampRate = length(bsRad)/eIristime(startT, endT);
[row, col] = find(strcmp(timeTable, 'P'));
bsPArriv = str2num(timeTable(row(1),4));
[row, col] = find(strcmp(timeTable, 'S'));
bsSArriv = str2num(timeTable(row(1),4));

[timeTable, ~] = mytaup(bdCords(1), convertLon(bdCords(2),'360to-180'), bdDepth);
startT = datestr(bdStart, 'yyyy-mm-ddTHH:MM:SS');
endT = datestr(bdEnd, 'yyyy-mm-ddTHH:MM:SS');
bdSampRate = length(bdRad)/eIristime(startT, endT);
[row, col] = find(strcmp(timeTable, 'P'));
bdPArriv = str2num(timeTable(row(1),4));
[row, col] = find(strcmp(timeTable, 'S'));
bdSArriv = str2num(timeTable(row(1),4));

% Plot particle motions
clf
figure(1)
titl(1) = parcleMotn(ssRad, ssTrans, ssVert, ssPArriv, ssSArriv, ssSampRate, 200, 400);
% titl(1).String = 'Small-Shallow';
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure06/figure02','-fillpage','-dpdf');
figure(2)
titl(2) = parcleMotn(bsRad, bsTrans, bsVert, bsPArriv, bsSArriv, bsSampRate, 200,400);
% titl(2).String = 'Large-Shallow';
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure06/figure03','-fillpage','-dpdf');
figure(3)
titl(3) = parcleMotn(bdRad, bdTrans, bdVert, bdPArriv, bdSArriv, bdSampRate, 200,400);
% titl(3).String = 'Large-Deep';
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure06/figure04','-fillpage','-dpdf');
%%
% Plot intermediate figs
clf
parcleZoom(bsStart, bsEnd, bsRad, bsTrans, bsVert, bsPArriv, bsSArriv,'Large Shallow');
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/test1','-fillpage','-dpdf');
clf
parcleZoom(ssStart, ssEnd, ssRad, ssTrans, ssVert, ssPArriv, ssSArriv,'Small Shallow');
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/test2','-fillpage','-dpdf');
clf
parcleZoom(bdStart, bdEnd, bdRad, bdTrans, bdVert, bdPArriv, bdSArriv,'Large Deep');
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/test3','-fillpage','-dpdf');





