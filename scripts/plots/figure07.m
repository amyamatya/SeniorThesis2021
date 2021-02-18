% Unstacked receiver functions
% run fetchRFQuakes, computeRFs first
clf
figure(5)
for i = 1:length(rf)
    subplot(1,length(rf),i)
    hold on
    [rf_d] = rfDepcon(rf{i}.d, rf{i}.h.delta, rf{i}.h.user(10)/deg2km(1), 0.1, 'iasp91', 'true');
    plot(rf_d, 0:0.1:800);
    axis ij
    title(sprintf('%d:%d:%d', rf{i}.h.nzhour, rf{i}.h.nzmin, rf{i}.h.nzsec));
    plot([0 0], [ylim],':');
    hold off
end
suplabel('Depth (m)','y');
sgtitle('Unstacked Receiver Functions');