function [theFig, ax] = traceplot3(theTrace, cords, rotation)
% Given trace, plot multi-component seismogram
% last edit 2/17/21 @aamatya
%---------Input variables----------------------------
% theTrace          - return of call to irisFetch.trace
% cords             - event coordinates
% rotation          - 'rotated' or 'unrotated'
% ---------------------------------------------------
azim = azimuth(cords, [theTrace(1).latitude convertLon(theTrace(1).longitude,'360to-180')]);
% Store signal data
for i = 1:length(theTrace)
    if theTrace(i).channel == 'BH1' | theTrace(i).channel == 'BHE'
        theTraces{1} = theTrace(i).data;
    elseif theTrace(i).channel == 'BH2' | theTrace(i).channel == 'BHN'
        theTraces{2}  = theTrace(i).data;
    elseif theTrace(i).channel == 'BHZ'
        theTraces{3} = theTrace(i).data;
    end
end
% Find y-limits
yMin = min(min([theTraces{1} theTraces{2} theTraces{3}]));
yMax = max(min([theTraces{1} theTraces{2} theTraces{3}]));
tims = 1:length(theTraces{1});
% calculate trace duration, distance, depths
t1 = datevec(theTrace(1).startTime);
t2 = datevec(theTrace(1).endTime);
elapTime = etime(t2, t1);
% plot parallel component
count = 1;
numPlots= cellfun(@isempty, theTraces);
numPlots = length(find(numPlots == 0));
if ~isempty(theTraces{1})
    ah(count) = subplot(numPlots,1,count);
    hold on
    if strcmp(rotation, 'unrotated')
        plot(tims, theTraces{1}, 'color',[.1+(count/4) .1+(count/4) .1+(count/4)]);
        ylabel(sprintf('North-South (%3.0f%s)', ...
            azim, char(176)));
        xlim([0 length(tims)]);
    elseif strcmp(rotation, 'rotated')
        if numPlots == 3
            [rad, ~,~] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZRT');
        elseif numPlots == 2 & (contains([theTrace.channel], 'BHN') | contains([theTrace.channel], 'BH1'))
            [rad, ~,~] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZR');
        elseif numPlots == 2 & (contains([theTrace.channel], 'BHE') | contains([theTrace.channel],'BH2'))
            [rad, ~,~] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZT');
        end
        plot(rad, 'color',[.1+(count/4) .1+(count/4) .1+(count/4)]);
        ylabel('Radial');
    end
    %     ylim([yMin yMax]);
    set(gca, 'xticklabels',[]);
    hold off
    count = count + 1;
end
% plot orthogonal component
if ~isempty(theTraces{2})
    ah(count) = subplot(numPlots,1,count);
    if strcmp(rotation, 'unrotated')
        plot(tims, theTraces{2}, 'Color',[.1+(count/4) .1+(count/4) .1+(count/4)]);
        ylabel(sprintf('East-West (%3.0f%s)', ...
            azim, char(176)));
        xlim([0 length(tims)]);
    elseif strcmp(rotation, 'rotated')
        if numPlots == 3
            [~,trans,~] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZRT');
        elseif numPlots == 2 & contains([theTrace.channel], 'BHE')
            [~,trans,~] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZR');
        elseif numPlots == 2 & contains([theTrace.channel], 'BHN')
            [~,trans,~] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZT');
        end
        plot(trans, 'Color',[.1+(count/4) .1+(count/4) .1+(count/4)]);
        ylabel('Transverse');
    end
    set(gca, 'xticklabels',[]);
%     ylim([yMin yMax]);
    hold off
    count = count + 1;
end
% vertical component
if ~isempty(theTraces{3})
    ah(count) = subplot(numPlots,1,count);
    if strcmp(rotation, 'unrotated')
        plot(tims, theTraces{3}, 'Color',[.1+(count/4) .1+(count/4) .1+(count/4)]);
        ylabel('Vertical');
        xlim([0 length(tims)]);
    elseif strcmp(rotation, 'rotated')
        if numPlots == 3
            [~,~,vert] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZRT');
        elseif numPlots == 2 & contains([theTrace.channel], 'BHE')
            [~,~,vert] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZR');
        elseif numPlots == 2 & contains([theTrace.channel], 'BHN')
            [~,~,vert] = myrotate(theTrace(1).station, theTrace(1).startTime, theTrace(1).endTime, azim, 'ZT');
        end
        plot(vert, 'Color',[.1+(count/4) .1+(count/4) .1+(count/4)]);
        ylabel('Vertical');
    end
%     ylim([yMin yMax]);
    set(gca, 'xtick', linspace(0, length(tims), 10), 'xtickLabel',linspace(0, elapTime, 10));
    xticklabels(linspace(0, ceil(elapTime), 10));
    suplabel('Time (s)', 'x');
    hold off
    % plot and label P- and S-wave Arrivals
    %     if exist('pArriv', 'var')
    %         axes(ah(1));
    %         [xaf, y1] = ds2nfu([pArriv pArriv], [ah(1).YLim(2)  0]);
    %         axes(ah(3));
    %         [xaf, y2] = ds2nfu([pArriv pArriv], [ah(3).YLim(1)  0]);
    %         yaf = [y1(1) y2(1)];
    %         annotation('line', xaf, yaf, 'Color','r','linestyle','--','linewidth',1);
    %         an1 = annotation('textarrow', [xaf(2)-.04 xaf(2)-.01], [yaf(1)-.02 yaf(1)-.02], 'String','P-Wave Arrival','Color','r');
    %         [xaf, ~] = ds2nfu([sArriv sArriv], [0 0]);
    %         annotation('line', xaf, yaf, 'Color','b','linestyle','--','linewidth',1);
    %         an2 = annotation('textarrow', [xaf(2)-.04 xaf(2)-.01], [yaf(1)-.02 yaf(1)-.02], 'String','S-Wave Arrival','Color','b');
    %         % label
    %         titleDate = datestr(startT, 'mm/dd/yy HH:MM');
    %         tittle = sgtitle(sprintf('Magnitude %3.1f, Distance %4.1f%s, Depth %i, %s', ...
    %             magnitude, epiDist, char(176), depth, titleDate));
    %         suplabel('Time (s)', 'x');
    %     else
    %         titleDate = datestr(startT, 'mm/dd/yy HH:MM');
    %         tittle = sgtitle(sprintf('Magnitude %3.1f, Distance %4.1f%s, Depth %i, %s', ...
    %             magnitude, epiDist, char(176), depth, titleDate));
    %         suplabel('Time (s)', 'x');
    %     end
    theFig = gcf;
    ax = gca;
end
end


