% figure03: SACV earthquake magnitude frequencies in and outside of donut
% Last modified: 2/13/21 @aamatya

% Get events inside donut
[sacvGet, sacvEvents] = getEvents('SACV',30, 90, 3, 9);
% Get events outside donut
[sacvGetOut, sacvEventsOut] = getEvents('SACV',0, 30, 3, 9);
[sacvGetOutOut, sacvEventsOutOut] = getEvents('SACV',90, 180, 3, 9);
sacvGetOut = [sacvGetOut sacvGetOutOut];
sacvEventsOut = [sacvEventsOut sacvEventsOutOut];
fn = fieldnames(sacvEventsOut);
for i=1:numel(fn)
    temp.(fn{i}) = [sacvEventsOut(1).(fn{i})' sacvEventsOut(2).(fn{i})'];
    sacvEventsOut.(fn{i}) = temp.(fn{i})';
end
% Get magnitude type frequencies
names = [string({sacvGet.PreferredMagnitudeType})...
    string({sacvGetOut.PreferredMagnitudeType})];
magTypes = unique(names);
magTypes = unique(lower(magTypes));
magFreqs = zeros(length(magTypes),1);
for i = 1:length(magTypes)
    magFreqs(i) = length(find(lower(names) == magTypes(i)));
end
[magFreqs, id] = sort(magFreqs,'descend');
magTypes = magTypes(id);
magTypes(4) = 'undefined';
magInfo = strings;
for i = 1:8
    if i == 1
        magInfo = strcat(magInfo, sprintf('%d %s, ', magFreqs(i), magTypes(i)));
    elseif i == 8
        magInfo = strcat(magInfo, sprintf(' %d %s', magFreqs(i), magTypes(i)));
    else 
        magInfo = strcat(magInfo, sprintf(' %d %s,', magFreqs(i), magTypes(i)));
    end
end
% Make frequency histograms
close all
figure;
% unique types
subplot(3,1,1)
barCats = categorical(magTypes(1:7));
barCats = reordercats(barCats,magTypes(1:7));
barCounts = magFreqs(1:7);
bar(barCats, barCounts,'FaceColor',[.5 .5 .5]);
ylim([0 max(barCounts) + 5e4]);
title('Types');
% curve-fitted event frequencies
subplot(3,1,2)
hold on
binEdges = 3:0.3:9;
binCenters = binEdges(1:end-1)+diff(binEdges)/2;
counts = histcounts(sacvEvents.mag, binEdges);
countsOut = histcounts(sacvEventsOut.mag, binEdges);
fd = fitdist(sacvEvents.mag,'normal');
fdOut = fitdist(sacvEventsOut.mag, 'normal');
h2 = histfit(sacvEventsOut.mag,length(3:0.3:9));
h2(1).FaceColor = [.2 .2 .9];
h2(1).FaceAlpha = 0.4;
h2(2).Color = [.2 .2 .9]; 
h1 = histfit(sacvEvents.mag,length(3:0.3:9));
h1(1).FaceColor = [.9 .2 .2];
h1(1).FaceAlpha = 0.3;
h1(2).Color = [.9 .2 .2];
ax1 = gca;
xlim([2 9]);
ylim([0 max([counts countsOut])]);
[~,lg] = legend([h2(1) h1(1)], sprintf('Outside of 30%c - 90%c %c n = %d, %c = %.1f, %c = %.1f',...
    char(176), char(176), char(10),length(sacvEventsOut.mag),  char(181), fdOut.mu, char(963), fdOut.sigma),...
    sprintf('Between 30%c - 90%c %c n = %d, %c = %.1f, %c = %.1f', char(176),...
    char(176),char(10), length(sacvEvents.mag),  char(181), fd.mu, char(963), fd.sigma));
lg(3).Children.FaceColor = [0 0 .8];
lg(4).Children.FaceColor = [.8 0 0];
title('Fitted');
sgtitle('Magnitude Frequency');
box on
hold off
% Y-Log event frequencies
subplot(3,1,3)
b = bar(binCenters, [countsOut; counts]','histc');
b(1).FaceColor = [.2 .2 .9];
b(2).FaceColor = [.9 .2 .2];
ph = get(gca,'children');
for i = 1:length(ph)
      vn = get(ph(i),'Vertices');
      vn(:,2) = vn(:,2) + 1;
      set(ph(i),'Vertices',vn)
end
set(gca,'yscale','log')
title('Log');
xlim([3 9.2]);
suplabel('Magnitude','x');
suplabel('Counts','y');
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure03','-dpdf');
clearvars -except sacvEvents sacvEventsOut sacvGet sacvGetOut

% % Alternative: fixed-bin-edge histogram
% binEdges = 3:0.3:9;
% counts = histcounts(sacvEvents.mag, binEdges);
% countsOut = histcounts(sacvEventsOut.mag, binEdges);
% binCenters = binEdges(1:end-1)+diff(binEdges)/2;
% ctrsx = linspace(min(binCenters), max(binCenters)); 
% % Calculate stats
% mu = mean(sacvEvents.mag);
% sd = std(sacvEvents.mag);
% muOut = mean(sacvEventsOut.mag);
% sdOut = std(sacvEventsOut.mag);
% ndfcn = @(mu,sd,x) exp(-(x-mu).^2 ./ (2*sd^2)) /(sd*sqrt(2*pi));
% ndfcnOut = @(muOut,sdOut,x) exp(-(x-muOut).^2 ./ (2*sdOut^2)) /(sdOut*sqrt(2*pi));
% sdnd = ndfcn(mu,sd,ctrsx);
% sdndOut = ndfcn(muOut,sdOut,ctrsx);
% % Plot histogram 
% hold on curve-fitted event frequencies
% % h1 = bar(binCenters, countsOut);
% h1 = histogram(sacvEventsOut.mag, binEdges);
% h1.FaceColor = rgb('LightSteelBlue');
% plot(ctrsx, sdnd*max(countsOut)/max(sdndOut), 'Color',rgb('LightSteelBlue')-0.1, 'LineWidth',2) 
% h1.FaceAlpha = 0.6;
% % h2 = bar(binCenters, counts);
% h2 = histogram(sacvEvents.mag, binEdges);
% h2.FaceColor = rgb('PaleVioletRed');
% h2.FaceAlpha = 0.3;
% plot(ctrsx, sdnd*max(counts)/max(sdnd), 'Color',rgb('PaleVioletRed')-0.1, 'LineWidth',2) 
% hold off
% xlim([2 9]);