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
rfdir = ['/Users/aamatya/Documents/MATLAB/ST2021/data/RFs'];
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
for i = 1:length(rfFiles)
        subplot(3,2,i)
    try
        poo = myStackRfs(rfFiles{i}(:));
        poo.Children.
    end
    
end









