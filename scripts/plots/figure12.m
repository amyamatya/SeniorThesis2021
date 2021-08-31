% figure12: stacks by depth, magnitude, ray parameter
%% Stack by depth
allDir = ['/Users/aamatya/Documents/MATLAB/ST2021/allCVEvents/RFs'];
rfs = dir(fullfile(allDir,'*RF.SAC'));
rfNames = {rfs.name};

z = (0:0.1:800)';
for i = 1:length(rfNames)
    [t, data, hdr] = fread_sac(fullfile(allDir, char(rfNames(i))));
    evDep(i) = hdr.evdp;
    evMag(i) = hdr.mag;
    rayParam(i) = hdr.user(10);
    rfDep{i} = rfDepcon(data,hdr.delta,hdr.user(10)/deg2km(1),0.1,'iasp91','false');
end

binz = [0 10 20 30 50 80 150 300 600];
% binz = exp(linspace(log(1e-9),log(600),15))
for i = 1:length(binz)-1
    binIds{i} = find(evDep > binz(i) & evDep < binz(i+1));
end

magBinz = [6 6.3 6.6 7 7.5 9];
for i = 1:length(magBinz)-1
    magIds{i} = find(evMag > magBinz(i) & evMag < magBinz(i+1));
end

rayBinz = linspace(min(rayParam), max(rayParam), 15);
for i = 1:length(rayBinz)-1
    rayIds{i} = find(rayParam > rayBinz(i) & rayParam < rayBinz(i+1));
end

clf
subplot(1,3,1)
hold on
count = 0;
for i = 1:length(binIds)
    [z, stack, mbstk, sdv] = myStackRfs(rfNames(binIds{i}), allDir, 'II');
    plot(stack+count, z);
    pos = stack;
    pos(stack < 0) = 0;
    neg = stack;
    neg(stack > 0) = 0;
    xPatchPos = [z, fliplr(z)];
    yPatchPos = [zeros(size(stack)), fliplr(pos)];
    xPatchNeg = [z, fliplr(z)];
    yPatchNeg = [zeros(size(stack)), fliplr(neg)];
    fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.3);
    fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
    count = count + 0.05;
end
axis ij
axis tight
xticks(linspace(0, count, length(binIds)));
title('Depth');
hold off

subplot(1,3,2)
hold on
count = 0;
for i = 1:length(magIds)
    [z, stack, mbstk, sdv] = myStackRfs(rfNames(magIds{i}), allDir, 'II');
    plot(stack+count, z);
    pos = stack;
    pos(stack < 0) = 0;
    neg = stack;
    neg(stack > 0) = 0;
    xPatchPos = [z, fliplr(z)];
    yPatchPos = [zeros(size(stack)), fliplr(pos)];
    xPatchNeg = [z, fliplr(z)];
    yPatchNeg = [zeros(size(stack)), fliplr(neg)];
    fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.3);
    fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
    count = count + 0.05;
end
axis ij
axis tight
xticks(linspace(0, count, length(magIds)));
title('Magnitude');
hold off

subplot(1,3,3)
hold on
count = 0;
for i = 1:length(rayIds)
    [z, stack, mbstk, sdv] = myStackRfs(rfNames(rayIds{i}), allDir, 'II');
    plot(stack+count, z);
    pos = stack;
    pos(stack < 0) = 0;
    neg = stack;
    neg(stack > 0) = 0;
    xPatchPos = [z, fliplr(z)];
    yPatchPos = [zeros(size(stack)), fliplr(pos)];
    xPatchNeg = [z, fliplr(z)];
    yPatchNeg = [zeros(size(stack)), fliplr(neg)];
    fill(yPatchPos+count,xPatchPos,'r','LineStyle','None','facealpha',0.3);
    fill(yPatchNeg+count,xPatchNeg,'b','LineStyle','None','facealpha',0.3);
    count = count + 0.05;
end
axis ij
axis tight
xticks(linspace(0, count, length(rayIds)));
title('Ray Parameter');
hold off
