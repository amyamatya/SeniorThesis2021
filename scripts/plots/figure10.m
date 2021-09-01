% figure10: plot of GW loops
[sacvTrace, svmaTrace, sharedMag, sharedDep, sharedCords, sharedDist] = sharedTrace();
eventTime =  datestr(sacvTrace(1).startTime, 'yyyy.mm.dd.HH.MM.SS');
% Read RFS dates
% copy shared trace to tryGW1 folder
evDir = ['/Users/aamatya/Documents/MATLAB/ST2021/tryGW1'];
rfs = dir(fullfile(evDir,'*.SAC'));
rfNames = string({rfs.name});
rfFiles = rfNames(strncmp(rfNames, eventTime,19));
rfDir = fullfile(evDir, 'RFs/');

clear
load rflexaTries.mat
evDir = ['/Users/aamatya/Documents/MATLAB/ST2021/tryGW1'];
rfs = dir(fullfile(evDir,'*.SAC'));
rfDir = fullfile(evDir, 'RFs/');
%%
clf
deps2 = 0:0.1:800;
count = 0;
hold on
for i = 1:length(stkGW)
    pos = stkGW{i};
    pos(pos < 0) = 0;
    neg = stkGW{i};
    neg(neg > 0) = 0;
    xPatchPos = [deps2, fliplr(deps2)];
    yPatchPos = [zeros(size(pos)), fliplr(pos)];
    xPatchNeg = [deps2, fliplr(deps2)];
    yPatchNeg = [zeros(size(neg)), fliplr(neg)];
    fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.25);
    fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.25);
    plot(stkGW{i}+count, deps2,'k');
    count = count + 0.025;
end
xlim([0 3]);
xticks(linspace(0, count-0.05, 5));
xticklabels(linspace(0.1, 1.5, 5));
% plot([0 100],[
yticks([0 410 660 800]);
set(gca, 'YGrid','on');
set(gca, 'XGrid','on');
set(gca, 'gridalpha',0.8);
set(gca, 'gridlinestyle','--');
axis tight
axis ij
hold off
xlabel('Gaussian Width Factor');
ylabel('Depth (km)');
title('All SACV RFs');

ax = gca;
ax1 = axes('Position',[ax.Position(1)+ 0.48 ax.Position(2)+0.155 ...
    ax.Position(3)-0.5 ax.Position(4)-0.2]);
hold on
colorz = linspace(0.1,0.4, 11);
count2 = 0;
deps = (0:0.1:800)';
for i = linspace(0.1, 1.5, 30)
    tryGWs(evDir, rfDir, '10',i);
    [t, data, hdr] = fread_sac(fullfile(rfDir, '2014.04.01.23.46.47.II.SACV.10.RF.SAC'));
    gwDepcon = rfDepcon(data,hdr.delta,hdr.user(10)/deg2km(1),0.1,'iasp91','false');
    pos = gwDepcon;
    pos(pos < 0) = 0;
    neg = gwDepcon;
    neg(neg > 0) = 0;
    xPatchPos = [deps, fliplr(deps)];
    yPatchPos = [zeros(size(pos)), fliplr(pos)];
    xPatchNeg = [deps, fliplr(deps)];
    yPatchNeg = [zeros(size(neg)), fliplr(neg)];
    fill(yPatchPos+count2,xPatchPos,'r','LineStyle','None','facealpha',0.2);
    fill(yPatchNeg+count2,xPatchNeg,'b','LineStyle','None','facealpha',0.2);
    plot(gwDepcon+count2, deps,'k');
    ax = gca;
    ax.GridAlpha = 0.6;
    count2 = count2 + 0.02;
end
xlim([0 0.7]);
axis ij
xticks(linspace(0, count2-0.03, 5));
title('04/01/14 01:23:46');
xticklabels(linspace(0.1, 1.5, 5));
yticks([0 410 660 800]);
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');
set(gca, 'gridalpha',0.8);
set(gca, 'gridlinestyle','--');
box on
hold off
set(gcf, 'papersize',[9 6]);
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure10/figure02',...
    '-fillpage','-dpdf','-r550');

%%
dataDir = '/Users/aamatya//Documents/MATLAB/ST2021/allSACVZEROEvents';
gwDir = '/Users/aamatya/Documents/MATLAB/ST2021/SACVZeroGwTries';
periodz = linspace(0.1, 1.5, 30);
for i = 1:length(periodz)
    rfDir = fullfile(gwDir, sprintf('RFs%.f',periodz(i)));
    tryGWs(dataDir, rfDir, '00',periodz(i));
    rfNames = dir(rfDir);
    rfNames = {rfNames.name};
    rfNames(1:2) = [];
    [zGW{i}, stkGW{i}] = myStackRfs(rfNames,rfDir,'SACV');
end
hold off

%%

% figure11: try different fcs
dataDir = '/Users/aamatya//Documents/MATLAB/ST2021/allSACVZEROEvents';
fcDir = '/Users/aamatya/Documents/MATLAB/ST2021/SACVZeroFcTries';
periodz = exp(linspace(log(50),log(3),60));
for i = 1:length(periodz)
    rfDir = fullfile(fcDir, sprintf('RFs%.f',periodz(i)));
    tryFCs(dataDir, rfDir, '00',1/periodz(i));
    rfNames = dir(rfDir);
    rfNames = {rfNames.name};
    rfNames(1:2) = [];
    [z{i}, stk{i}] = myStackRfs(rfNames,rfDir,'SACV');
end
hold off

%% example stack

clf
deps2 = 0:0.1:800;
count = 0;
hold on
pos = stkGW{1};
pos(pos < 0) = 0;
neg = stkGW{1};
neg(neg > 0) = 0;
xPatchPos = [deps2, fliplr(deps2)];
yPatchPos = [zeros(size(pos)), fliplr(pos)];
xPatchNeg = [deps2, fliplr(deps2)];
yPatchNeg = [zeros(size(neg)), fliplr(neg)];
fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.3);
fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
plot(stkGW{1}+count, deps2,'k');

pos = stkGW{end};
pos(pos < 0) = 0;
neg = stkGW{end};
neg(neg > 0) = 0;
xPatchPos = [deps2, fliplr(deps2)];
yPatchPos = [zeros(size(pos)), fliplr(pos)];
xPatchNeg = [deps2, fliplr(deps2)];
yPatchNeg = [zeros(size(neg)), fliplr(neg)];
fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.3);
fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
plot(stkGW{end}+count, deps2,'k');
plot([0 0],[0 800],'k--','linewidth',1.3);
yticks([0 410 660 800]);
set(gca, 'YGrid','on');
% set(gca, 'XGrid','on');
lgd = legend('GW=0.1','GW=1.5','location','southeast');
hLegend = findobj(lgd, 'Type', 'Patch');
set(gca, 'gridalpha',0.8);
set(gca, 'gridlinestyle','--');
axis tight
axis ij
hold off
xlabel('$\bar{f}_{Z \rightarrow R}(p,z)$');
ylabel('Depth (km)');
set(gcf, 'PaperSize',[4 6]);
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure10/figure01',...
    '-fillpage','-dpdf','-r550');
