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
%%
clf
deps = 0:0.1:800;
count = 0;
hold on
for i = 1:length(stk)
    pos = stk{i};
    pos(pos < 0) = 0;
    neg = stk{i};
    neg(neg > 0) = 0;
    xPatchPos = [deps, fliplr(deps)];
    yPatchPos = [zeros(size(pos)), fliplr(pos)];
    xPatchNeg = [deps, fliplr(deps)];
    yPatchNeg = [zeros(size(neg)), fliplr(neg)];
    fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.3);
    fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
    plot(stk{i}+count, deps,'k');
    count = count + 0.03;
end
xlim([0 count]);
count = count-0.05;
xticks(linspace(0, count, 5));
xticklabels(round(exp(linspace(log(50),log(3),5))));
yticks([0 410 660 800]);
set(gca, 'YGrid','on');
set(gca, 'gridalpha',0.6);
set(gca, 'gridlinestyle','--');
axis tight
axis ij
hold off
set(gcf, 'papersize',[10 7]);
% xlabel('$\bar{f}_{Z \rightarrow R}(p,z)$','Interpreter','Latex');
xlabel('Period (s)');
ylabel('Depth (km)');
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure11',...
    '-fillpage','-dpdf','-r450');
%%
for i = 1:length(stk)
    stkMatrx(:,i) = stk{i};
end
clf
% contourf(periodz,0:0.1:800, stkMatrx);
contourf(stkMatrx);
% set(gca, 'XScale', 'log')
colormap(spring)
colorbar
axis ij
%% frequency hist
fcDir = '/Users/aamatya/Documents/MATLAB/ST2021/SACVZeroFcTries';
poop = dir(fcDir);
poop = string({poop.name});
poop(1:3) = [];

for i = 1:length(poop)
    currentDir = fullfile(fcDir, poop(i));
    currentRFDir = dir(currentDir);
    currentRFDir = string({currentRFDir.name});
    currentRFDir(1:2) = [];
    if isempty(currentRFDir)
        lats{i} = 0; lons{i} = 0; mags{i} = 0; deps{i} = 0;
        fits{i} = 0; j{i} = 0;
    else
    [lats{i}, lons{i}, mags{i}, deps{i}, fits{i}, j{i}] = ...
        myStackRfsStats(currentRFDir, currentDir, 'SACV') ; 
    end
end

for i = 1:length(poop)
    triez(i) = str2double(extractAfter(poop(i), 3));   
end

plot(triez, [cell2mat(j)],'*')
%%

rfDir = '/Users/aamatya/Documents/MATLAB/ST2021/allSACVZEROEvents/RFs';
poop = dir(rfDir);
poop = string({poop.name});
poop(1:2) = [];
zeroLength = length(poop);
for i = 1:zeroLength
    [~, ~, hdr] = fread_sac(char(fullfile(rfDir, poop(i))));
    zeroMags(i) = hdr.mag;
    zeroDep(i) = hdr.evdp;
end
[newZerolats, newZerolons, newZeromags, newZerodeps, newZerofits, newZeroj] =...
    myStackRfsStats(poop, rfDir, 'SACV');

rfDir = '/Users/aamatya/Documents/MATLAB/ST2021/allSACVTENEvents/RFs';
poop = dir(rfDir);
poop = string({poop.name});
poop(1:2) = [];
tenLength = length(poop);
for i = 1:tenLength
    [~, ~, hdr] = fread_sac(char(fullfile(rfDir, poop(i))));
    tenMags(i) = hdr.mag;
    tenDep(i) = hdr.evdp;
end
[newTenlats, newTenlons, newTenmags, newTendeps, newTenfits, newTenj] =...
    myStackRfsStats(poop, rfDir, 'SACV');

rfDir = '/Users/aamatya/Documents/MATLAB/ST2021/allSVMAEvents/RFs';
poop = dir(rfDir);
poop = string({poop.name});
poop(1:2) = [];
svmaLength = length(poop);
for i = 1:svmaLength
    [~, ~, hdr] = fread_sac(char(fullfile(rfDir, poop(i))));
    svmaMags(i) = hdr.mag;
    svmaDep(i) = hdr.evdp;
end
[newSvmalats, newSvmalons, newSvmamags, newSvmadeps, newSvmafits, newSvmaj] =...
    myStackRfsStats(poop, rfDir, 'SACV');

oldMags = [zeroMags tenMags svmaMags];
oldDeps = [zeroDep tenDep svmaDep];
newMags = [newZeromags newTenmags newSvmamags];
newDeps = [newZerodeps newTendeps newSvmadeps];
%%
clf
subplot(2,1,1)
hold on
h1 = histogram(oldMags, 6:0.25:8.5);
h2 = histogram(newMags, 6:0.25:8.5);
h1.FaceColor = [.4 .4 .4];
h2.FaceColor = [.8 .8 .8];
h1.FaceAlpha = 1;
h2.FaceAlpha = 1;
ax = gca;
ax.YGrid = 'on';
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5;
ylim([min(min([h1.Values h2.Values])) max(max([h1.Values h2.Values]))]);
xlabel('Magnitude');
hold off
legend('Pre-Stack','Post-Stack');

subplot(2,1,2)
hold on
h3 = histogram(oldDeps);
h4 = histogram(newDeps);
h3.FaceColor = [.4 .4 .4];
h4.FaceColor = [.8 .8 .8];
h3.FaceAlpha = 1;
h4.FaceAlpha = 1;
ax = gca;
ax.YGrid = 'on';
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5;
xlabel('Depth (km)');
ylim([min(min([h3.Values h4.Values])) max(max([h3.Values h4.Values]))]);
hold off
set(gcf, 'papersize',[7 5]);
suplabel('\# of Receiver Functions','y');
print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure13','-fillpage','-dpdf');
