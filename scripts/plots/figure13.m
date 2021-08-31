% figure13: histogram of all CV stack

% Read RFS dates
rfDir = ['/Users/aamatya/Documents/MATLAB/ST2021/allCVEvents/RFs'];
rfs = dir(fullfile(rfDir,'*RF.SAC'));
rfNames = {rfs.name};
% Get hist info
[evlat, evlon, evmag, evdep, fits] = myStackRfsStats(string(rfNames), ...
    ['/Users/aamatya/Documents/MATLAB/ST2021/allCVEvents/RFs'],...
    'SVMA');


% Plot each channel
clf
hold on
clear z stk mbstk sdv
[z, stk, mbstk, sdv, rfLength] = myStackRfs(string(rfNames), ...
    ['/Users/aamatya/Documents/MATLAB/ST2021/allCVEvents/RFs'],...
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
set(gca, 'YDir','reverse')
set(gca, 'YDir','reverse')
xlim([-.5 .5]);
ax.GridAlpha = 0.15;
ax.LineWidth = 1.5;
set(gca, 'YTick', [0 410 660 800])
set(gca, 'YGrid','on');