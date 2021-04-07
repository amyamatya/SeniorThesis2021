% figure07: RF stacks by instrument deployment (channel)
%------------------------------------------------------------------------
% Get channel dates
station = irisFetch.Stations('CHANNEL','II','SACV','00','BH*');
startDates = {station.Channels.StartDate};
startDates = unique(datenum(startDates, 'yyyy-mm-dd HH:MM:SS'));
endDates = {station.Channels.EndDate};
endDates(cellfun(@isempty, endDates)) = {datestr(date, 'yyyy-mm-dd HH:MM:SS')};
endDates = unique(datenum(endDates, 'yyyy-mm-dd HH:MM:SS'));
% Read RFS dates
rfdir = ['/Users/aamatya/Documents/MATLAB/ST2021/allCVEvents/RFs'];
rfs = dir(fullfile(rfdir,'*RF.SAC'));
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
% Plot each channel
romnums = {'I','II','III','IV','V','VI'};
figure(1)
for i = [1:4 6]
    %     try
    subplot(2,3,i)
    hold on
    [z{i}, stk{i}, mbstk{i}, sdv{i}] = myStackRfs(rfFiles{i}(:));
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
    xlabel('$\bar{f}_{Z \rightarrow R}(p,z)$','Interpreter','Latex');
    ylabel('Depth (km)');
    title(sprintf('%s: %s-%s',string(romnums(i)), datestr(startDates(i),'mm/dd/yy'), datestr(endDates(i),'mm/dd/yy')));
    set(gca, 'YDir','reverse')
    set(gca, 'YDir','reverse')
    xlim([-.5 .5]);
set(gca, 'YTick', [0 410 660 800])
set(gca, 'YGrid','on');
    %     catch
    %         continue
    %     end
end
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure07','-fillpage','-dpdf');

%% all files together
% IASP arrival time
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



