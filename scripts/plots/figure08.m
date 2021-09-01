% figure08: velocity profile at 410 and 660
iasp = dlmread('/Users/aamatya/Documents/MATLAB/ST2021/functions/rflexa/matlab/external/IASP91.tvel','',2,0);
z = iasp(:,1);
vp = iasp(:,2);
vs = iasp(:,3);
lim410 = [410-100 410+100];
lim660 = [660-100 660+100];
clf
poop = figure(1);
subplot(1,3,1)
ax = gca;
ax.Position(1) = ax.Position(1)-0.05;
hold on
vpPlot = plot(vp, z,'r','linewidth',2);
vsPlot = plot(vs, z,'b','linewidth',2);
plot([ax.XLim(1)-2 ax.XLim(2)], [30 30],'k:','linewidth',2);
plot([ax.XLim(1)-8 ax.XLim(1)-1], [30 30],'k:','linewidth',2);
plot([ax.XLim(1)-10 ax.XLim(2)], [2890 2890],'k:','linewidth',2);
plot([ax.XLim(1)-10 ax.XLim(2)], [5140 5140],'k:','linewidth',2);
plot([ax.XLim(1)-10 ax.XLim(2)], [410 410],'k:','linewidth',2);
plot([ax.XLim(1)-10 ax.XLim(2)], [660 660],'k:','linewidth',2);
text(-5.9, 30, 'Crust');
h = text(-6.2, 280, 'Upper');
h = text(-6.4, 540, 'Mantle');
text(-6.3, 2500, 'Lower');
text(-6.5, 2700, 'Mantle');
text(-7.7, 4000, 'Outer Core');
text(-7.6, 5800, 'Inner Core');
plot([0 0], [0 max(z)],'k','linewidth',1);
vpBox = annotation('textbox',[.22 .88 .1 .1],'String','V_p','color','r');
vsBox = annotation('textbox',[.18 .88 .1 .1],'String','V_s','color','b');
vpBox.EdgeColor = 'None'; vsBox.EdgeColor = 'None';
xlabel('Velocity (km/s)');
ylabel('Depth (km)');
xlim([min(min([vp vs]))-8 max(max([vp vs]))]);
ylim([min(z) max(z)]);
ax = gca;
obj = addgradient(ax, [1 0 0],[1 1 0]);
obj.FaceAlpha = '0.5';
obj.EdgeColor = 'k';
ax.YGrid = 'on';
axis ij
hold off
% next fig
width = ax.Position(3)*0.85;
height = ax.Position(4)*0.85;
xPos = ax.Position(1) + 0.34;
yPos = ax.Position(2) + (ax.Position(4) - height)/2;
ax1 = axes('Position',[xPos yPos width height]);
ax1.YGrid = 'on';
hold on
plot(vp(z<900), z(z<900),'r','linewidth',2);
plot(vs(z<900), z(z<900),'b','linewidth',2);
plot([ax.XLim(1) ax.XLim(2)], [410 410],'k:','linewidth',2);
plot([ax.XLim(1) ax.XLim(2)], [660 660],'k:','linewidth',2);
xlim([min(min([vp(z<900) vs(z<900)])) max(max([vp(z<900) vs(z<900)]))])
annotation('line',[ax.Position(1)+ax.Position(3) ax1.Position(1)],...
    [ax.Position(4) 0.17]);
annotation('line',[ax.Position(1)+ax.Position(3) ax1.Position(1)],...
    [0.92 0.86]);
vpBox = annotation('textbox',[.46 .82 .1 .1],'String','V_p','color','r');
vsBox = annotation('textbox',[.4 .82 .1 .1],'String','V_s','color','b');
vpBox.EdgeColor = 'None'; vsBox.EdgeColor = 'None';
obj = addgradient(ax1, [1 0.6 0],[1 1 0]);
obj.FaceAlpha = '0.5';
ylim([0 max(z(z<900))]);
box on
axis ij
hold off
% next fig
width = ax.Position(3)*1.2;
height = ax1.Position(4)/2.7;
xPos = ax1.Position(1) + 0.3;
yPos = ax1.Position(2) + (ax1.Position(4)/2);
ax2 = axes('Position',[xPos yPos width height]);
ax2.YGrid = 'on';
hold on
plot(vs(z>=lim410(1) & z<=lim410(2))+2.7, z(z>=lim410(1) & z<=lim410(2)),'k','linewidth',2);
plot(vs(z>=lim410(1) & z<=900), z(z>=lim410(1) & z<=900)-50,'k','linewidth',2);
plot(vs(z>=200 & z<=900)+5.7, z(z>=200 & z<=900)+50,'k','linewidth',2);
plot([ax.XLim(1) ax.XLim(2)], [410 410],'k:','linewidth',2);
plot([6.3 6.3],[0 750],'k','linewidth',1);
plot([9.2 9.2],[0 760],'k','linewidth',1);
obj = addgradient(ax2, [1 0.75 0],[1 0.9 0]);
obj.FaceAlpha = '0.5';
xMin = min(min([vp(z>=lim410(1) & z<=lim660(2)) vs(z>=lim410(1) & z<=lim660(2))]));
xMax = max(max([vp(z>=lim410(1) & z<=lim660(2)) vs(z>=lim410(1) & z<=lim660(2))]));
xlim([xMin-1 xMax+1]);
ylim(lim410)
box on
set(gca, 'XTickLabel',[]);
axis ij
hold off
% next fig
width = ax.Position(3)*1.2;
height = ax1.Position(4)/2.7;
xPos = ax1.Position(1) + 0.3;
yPos = ax2.Position(2)-0.28;
ax3 = axes('Position',[xPos yPos width height]);
ax3.YGrid = 'on';
hold on
box on
plot(vs(z>=500 & z<=740)-0.8, z(z>=500 & z<=740)+50,'k','linewidth',2);
plot(vs(z>=lim660(1) & z<=lim660(2))+2, z(z>=lim660(1) & z<=lim660(2)),'k','linewidth',2);
plot(vs(z>=lim660(1) & z<=900)+5, z(z>=lim660(1) & z<=900)-50,'k','linewidth',2);
plot([ax.XLim(1) ax.XLim(2)], [660 660],'k:','linewidth',2);
plot([6.3 6.3],[0 760],'k','linewidth',1);
plot([9.2 9.2],[0 760],'k','linewidth',1);
obj = addgradient(ax3, [1 0.7 0],[1 0.8 0]);
obj.FaceAlpha = '0.5';
axis ij
% xMin = min(min([vp(z>=lim660(1) & z<=lim660(2)) vs(z>=lim660(1) & z<=lim660(2))]));
% xMax = max(max([vp(z>=lim660(1) & z<=lim660(2)) vs(z>=lim660(1) & z<=lim660(2))]));
xlim([xMin-1 xMax+1]);
ylim(lim660);
vpBox = annotation('textbox',[.74 .72 .1 .1],'String','-{\Delta}T','Color','b');
vsBox = annotation('textbox',[.83 .72 .1 .1],'String','0','Color','k');
vzBox = annotation('textbox',[.91 .72 .1 .1],'String','+{\Delta}T','Color','r');
vpBox.EdgeColor = 'None'; vsBox.EdgeColor = 'None'; vzBox.EdgeColor = 'None'; 
annotation('line',[ax1.Position(1)+ax1.Position(3) ax2.Position(1)],...
    [0.51 0.77]);
annotation('line',[ax1.Position(1)+ax1.Position(3) ax2.Position(1)],...
    [0.51 0.52]);
annotation('line',[ax1.Position(1)+ax1.Position(3) ax2.Position(1)],...
    [0.29 0.49]);
annotation('line',[ax1.Position(1)+ax1.Position(3) ax2.Position(1)],...
    [0.29 0.24]);
hold off
set(gca,'xticklabel',[]);
sgtitle('IASP91 Velocity Profile');
set(gcf, 'PaperSize',[10 6]);
print(poop, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure08','-fillpage','-dpdf'); 