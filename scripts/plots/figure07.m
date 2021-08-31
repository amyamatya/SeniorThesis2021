% figure07: RF stacks by instrument deployment (channel)
%------------------------------------------------------------------------
%% SACV Location 00
% Get channel dates
station = irisFetch.Stations('CHANNEL','II','SACV','00','BH*');
startDates = {station.Channels.StartDate};
startDates = unique(datenum(startDates, 'yyyy-mm-dd HH:MM:SS'));
endDates = {station.Channels.EndDate};
endDates(cellfun(@isempty, endDates)) = {datestr(date, 'yyyy-mm-dd HH:MM:SS')};
endDates = unique(datenum(endDates, 'yyyy-mm-dd HH:MM:SS'));
% Read RFS dates
rfDir = ['/Users/aamatya/Documents/MATLAB/ST2021/allSACVZEROEvents/RFs'];
rfs = dir(fullfile(rfDir,'*RF.SAC'));
rfNames = {rfs.name};
rfDates = [extractBefore(rfNames, '.II')];
rfDates = datenum(rfDates, 'yyyy.mm.dd.HH.MM.SS');
% Select RFs
for i = 1:length(startDates)
    rfFiles{i} = rfDates(find(rfDates > startDates(i) & rfDates < endDates(i)));
    rfFiles{i} = string(datestr(rfFiles{i}, 'yyyy.mm.dd.HH.MM.SS'));
    for j = 1: length(rfFiles{i})
        rfFiles{i}(j) = sprintf('%s.II.SACV.00.RF.SAC',rfFiles{i}(j));
    end
end
for i = 1:length(rfFiles)
    rfPreLength(i) = length(rfFiles{i});
end
% Plot each channel
romnums = {'I','II','III','IV','V','VI'};
sbLabels = {'A','B','C','D','E','F'};
clf
for i = [1:4 6]
    %     try
    subplot(2,3,i)
    hold on
    [z{i}, stk{i}, mbstk{i}, sdv{i}, rfLength(i)] = myStackRfs(rfFiles{i}(:), ...
        ['/Users/aamatya/Documents/MATLAB/ST2021/allSACVZeroEvents/RFs'],...
        'SACV');
    pos = mbstk{i} - (2.*sdv{i});
    pos(pos < 0) = 0;
    neg = mbstk{i} + (2.*sdv{i});
    neg(neg > 0) = 0;
    xPatchPos = [z{i}, fliplr(z{i})];
    yPatchPos = [zeros(size(mbstk{i})), fliplr(pos)];
    xPatchNeg = [z{i}, fliplr(z{i})];
    yPatchNeg = [zeros(size(mbstk{i})), fliplr(neg)];
    plot(stk{i}, z{i});
    plot(mbstk{i} + 2.*sdv{i},z{i},'color',[.7 .7 .7])
    plot(mbstk{i} - 2.*sdv{i},z{i},'color',[.7 .7 .7])
    fill(yPatchPos,xPatchPos,'r','LineStyle','None');
    fill(yPatchNeg,xPatchNeg,'b','LineStyle','None');
    ax = gca;
    text(0.3, 780, sprintf('n=%d',rfLength(i)));
    %     annotation('textbox',[ax.Position],'String',sprintf('%s',sbLabels{i}),...
    %         'FitBoxToText','on','Margin',0.5,'BackgroundColor',[.9 .9 .9]);
    title(sprintf('%s: %s-%s',string(romnums(i)), datestr(startDates(i),'mm/dd/yy'), datestr(endDates(i),'mm/dd/yy')));
    set(gca, 'YDir','reverse')
    ax.GridAlpha = 0.15;
    ax.LineWidth = 1.5;
    xlim([-.5 .5]);
    set(gca, 'YTick', [0 410 660 800])
    set(gca, 'YGrid','on');
end
subplot(2,3,5)
ax = gca;
axPosition(1) = ax.Position(1) + 0.03;
ax.Position(2) = ax.Position(2) + 0.05;
ax.Position(4) = ax.Position(4)*0.7;
hold on
c = categorical(romnums([1:4 6]));
bar(c, rfPreLength([1:4 6]),'FaceColor',[.5 .5 .5]);
bar(c, rfLength([1:4 6]),'FaceColor',[.75 .75 .75]);
set(gca, 'YGrid','on');
ax.GridAlpha = 0.37;
ax.GridLineStyle = '--';
ax.LineWidth = 1;
title('\rm\# of RFs');
legend('Pre-Filter','Post-Filter','location','northwest');
xlabel('Channel');
axis tight
yticks(linspace(0, max(rfPreLength), 9));
labels = string(ax.YAxis.TickLabels);
labels(2:2:end) = nan;
ax.YAxis.TickLabels = labels;
box on
hold off
set(gcf, 'PaperSize',[10 8]);
suplabel('$\bar{f}_{Z \rightarrow R}(p,z)$','x');
suplabel('Depth (km)','y');
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure07/figure01','-fillpage','-dpdf');
%% SACV Location 10
% Get channel dates
station = irisFetch.Stations('CHANNEL','II','SACV','10','BH*');
startDates = {station.Channels.StartDate};
startDates = unique(datenum(startDates, 'yyyy-mm-dd HH:MM:SS'));
endDates = {station.Channels.EndDate};
endDates(cellfun(@isempty, endDates)) = {datestr(date, 'yyyy-mm-dd HH:MM:SS')};
endDates = unique(datenum(endDates, 'yyyy-mm-dd HH:MM:SS'));
% Read RFS dates
rfDir = ['/Users/aamatya/Documents/MATLAB/ST2021/allSACVTENEvents/RFs'];
rfs = dir(fullfile(rfDir,'*RF.SAC'));
rfNames = {rfs.name};
rfDates = [extractBefore(rfNames, '.II')];
rfDates = datenum(rfDates, 'yyyy.mm.dd.HH.MM.SS');
% Select RFs
for i = 1:length(startDates)
    rfFiles{i} = rfDates(find(rfDates > startDates(i) & rfDates < endDates(i)));
    rfFiles{i} = string(datestr(rfFiles{i}, 'yyyy.mm.dd.HH.MM.SS'));
    for j = 1: length(rfFiles{i})
        rfFiles{i}(j) = sprintf('%s.II.SACV.10.RF.SAC',rfFiles{i}(j));
    end
end
for i = 1:length(rfFiles)
    rfPreLength(i) = length(rfFiles{i});
end
% Plot each channel
romnums = {'I','II','III','IV'};
clf
for i = 1:4
subplot(1,4,i)
    hold on
    [z{i}, stk{i}, mbstk{i}, sdv{i},rfLength(i)] = myStackRfs(rfFiles{i}(:), ...
        ['/Users/aamatya/Documents/MATLAB/ST2021/allSACVTENEvents/RFs'],...
        'SACV');
    pos = mbstk{i} - (2.*sdv{i});
    pos(pos < 0) = 0;
    neg = mbstk{i} + (2.*sdv{i});
    neg(neg > 0) = 0;
    xPatchPos = [z{i}, fliplr(z{i})];
    yPatchPos = [zeros(size(mbstk{i})), fliplr(pos)];
    xPatchNeg = [z{i}, fliplr(z{i})];
    yPatchNeg = [zeros(size(mbstk{i})), fliplr(neg)];
    plot(stk{i}, z{i});
    plot(mbstk{i} + 2.*sdv{i},z{i},'color',[.7 .7 .7])
    plot(mbstk{i} - 2.*sdv{i},z{i},'color',[.7 .7 .7])
    ax = gca;
    fill(yPatchPos,xPatchPos,'r','LineStyle','None');
    fill(yPatchNeg,xPatchNeg,'b','LineStyle','None');
    text(0.3, 780, sprintf('n=%d',rfLength(i)));
    %     annotation('textbox',[ax.Position],'String',sprintf('%s',sbLabels{i}),...
    %         'FitBoxToText','on','Margin',0.5,'BackgroundColor',[.9 .9 .9]);
    title(sprintf('%s: %s-%s',string(romnums(i)), datestr(startDates(i),'mm/dd/yy'), datestr(endDates(i),'mm/dd/yy')));
    set(gca, 'YDir','reverse')
    xlim([-.5 .5]);
    set(gca, 'YTick', [0 410 660 800])
    set(gca, 'YGrid','on');
end
set(gcf, 'papersize',[12 6]);
suplabel('Depth (km)','y');
suplabel('$\bar{f}_{Z \rightarrow R}(p,z)$','x');
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure07/figure02','-fillpage','-dpdf');
%% SVMA
station = irisFetch.Stations('CHANNEL','AF','SVMA','','BH*');
% Read RFS dates
rfDir = ['/Users/aamatya/Documents/MATLAB/ST2021/allSVMAEvents/RFs'];
rfs = dir(fullfile(rfDir,'*RF.SAC'));
rfNames = {rfs.name};
% Plot each channel
clf
hold on
clear z stk mbstk sdv
[z, stk, mbstk, sdv, rfLength] = myStackRfs(string(rfNames), ...
    ['/Users/aamatya/Documents/MATLAB/ST2021/allSVMAEvents/RFs'],...
    'SVMA');
pos = mbstk - (2.*sdv);
pos(pos < 0) = 0;
neg = mbstk + (2.*sdv);
neg(neg > 0) = 0;
xPatchPos = [z, fliplr(z)];
yPatchPos = [zeros(size(mbstk)), fliplr(pos)];
xPatchNeg = [z, fliplr(z)];
yPatchNeg = [zeros(size(mbstk)), fliplr(neg)];
plot(stk, z);
plot(mbstk + 2.*sdv,z,'color',[.7 .7 .7])
plot(mbstk - 2.*sdv,z,'color',[.7 .7 .7])
fill(yPatchPos,xPatchPos,'r','LineStyle','None');
fill(yPatchNeg,xPatchNeg,'b','LineStyle','None');
xlabel('$\bar{f}_{Z \rightarrow R}(p,z)$','Interpreter','Latex');
ylabel('Depth (km)');
title('02/01/14-12/26/14');
text(0.3, 780, sprintf('n=%d',rfLength));
set(gca, 'YDir','reverse')
set(gca, 'YDir','reverse')
xlim([-.5 .5]);
set(gca, 'YTick', [0 410 660 800])
set(gca, 'YGrid','on');
set(gcf, 'papersize',[4 6]);
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure07/figure03','-fillpage','-dpdf');
%% All CV retrievals

figure(2)
iasp = dlmread('/Users/aamatya/Documents/MATLAB/ST2021/functions/rflexa/matlab/external/IASP91.tvel','',2,0);
zee = iasp(:,1);
veep = iasp(:,2);
vees = iasp(:,3);
hold on
i = 1;
[z{i}, stk{i}, mbstk{i}, sdv{i}] = myStackRfs([rfNames]);
pos = mbstk{i} - (2.*sdv{i});
pos(pos < 0) = 0;
neg = mbstk{i} + (2.*sdv{i});
neg(neg > 0) = 0;
xPatchPos = [z{i}, fliplr(z{i})];
yPatchPos = [zeros(size(mbstk{i})), fliplr(pos)];
xPatchNeg = [z{i}, fliplr(z{i})];
yPatchNeg = [zeros(size(mbstk{i})), fliplr(neg)];
plot(stk{i}, z{i});
plot(mbstk{i} + 2.*sdv{i},z{i},'k:')
plot(mbstk{i} - 2.*sdv{i},z{i},'k:')
fill(yPatchPos,xPatchPos,'r','LineStyle','None');
fill(yPatchNeg,xPatchNeg,'b','LineStyle','None');
xlabel('$\bar{f}_{Z \rightarrow R}(p,z)$','Interpreter','Latex');
ylabel('Depth (km)');
set(gca, 'YDir','reverse')
set(gca, 'YTick', [0 410 660 800])
set(gca, 'YGrid','on');
hold off

zArray = cell2mat(z);
stkArray = cell2mat(stk);
id410 = find(zArray>370 & zArray < 460);
id660 = find(zArray>610 & zArray < 710);
maxId410 = find(stkArray(id410) ==  max(stkArray(id410)));
maxId660 = find(stkArray(id660) ==  max(stkArray(id660)));
peakDepth410 = zArray(id410(maxId));
peakDepth660 = zArray(id660(maxId));
title(sprintf('All CV Retrievals'));



%% all RFS unstacked
clf
count = 0;
z = (0:0.1:800)';
hold on
for i = 1:length(rfFiles)-1
    for j = 1:length(rfFiles{i})-1
        [t, data, hdr] = fread_sac(fullfile(rfDir, char(rfFiles{i}(j))));
        rfDep = rfDepcon(data,hdr.delta,hdr.user(10)/deg2km(1),0.1,'iasp91','false');
        plot(rfDep+count, z);
        pos = rfDep+count;
        pos(rfDep < 0) = 0;
        neg = rfDep+count;
        neg(rfDep > 0) = 0;
        xPatchPos = [z, fliplr(z)];
        yPatchPos = [zeros(size(rfDep)), fliplr(pos)];
        xPatchNeg = [z, fliplr(z)];
        yPatchNeg = [zeros(size(rfDep)), fliplr(neg)];
        fill(yPatchPos,xPatchPos,'r','LineStyle','None','facealpha',0.3);
        fill(yPatchNeg,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
        %         pos = find(rfDep > 0);
        %         neg = find(rfDep < 0);
        %         fill([rfDep(pos)+count fliplr(rfDep(pos)+count)], [repmat(count,...
        %             length(z(pos)), 1) z(pos) ],'r','FaceAlpha',0.3);
        %         fill([rfDep(neg)+count fliplr(rfDep(neg)+count)], [ repmat(count,...
        %             length(z(neg)), 1) z(neg)],'b','FaceAlpha',0.3);
        axis ij
        count = count + 0.05;
    end
end
hold off


