function [z, stack, j, stats, mag, depth] = myStackRfsStats(rfNames, rfdir, station)
% Adaptation of stackRFs.m from aburky@princeton.edu to take inputs
% Stack existing receiver functions
%---------Input Variables------------------------------------
% rfNames               - file paths to stored RFs
%------------------------------------------------------------
% Flag indicating whether PP is included or not
PP = false;
% Set QC parameters
snr_z = 2;
snr_r = 2;
nu = 0.1;
fit = 80;
if PP == true
    gcarc = 29;
else
    gcarc = 35;
end

% Read in receiver functions which match QC criteria
j = 1;
for i = 1:length(rfNames)
    try
        [rf_0{i}.t, rf_0{i}.d, rf_0{i}.h] = fread_sac(fullfile(rfdir, rfNames(i)));
    catch
        [rf_0{i}.t, rf_0{i}.d, rf_0{i}.h] = fread_sac(fullfile(rfdir, char(rfNames(i))));
    end
    if rf_0{i}.h.user(1) > snr_z && rf_0{i}.h.user(2) > snr_r && ...
            rf_0{i}.h.user(3) > fit && rf_0{i}.h.user(4) > nu && ...
            rf_0{i}.h.gcarc >= gcarc
        % Keep receiver functions which pass all QC
        keyboard
        rf{j} = rf_0{i};
        gcarcs(j) = rf{j}.h.gcarc;
        evla(j) = rf{j}.h.evla;
        evlo(j) = rf{j}.h.evlo;
        rf{j}.d = rf{j}.d/max(rf{j}.d(1:round(20/rf{j}.h.delta)));
        [~,shidx] = max(rf{j}.d(1:round(20/rf{j}.h.delta)));
        rf{j}.d = rf{j}.d(shidx:end);
        npts(j) = length(rf{j}.d);
        P(j) = rf{j}.h.user(10);
        j = j + 1;
    end
end

% clear rf_0 rfs rfdir
% if ~exist('npts','var')
%     keyboard
% end
% Make the length of the data vectors and sample rates consistent
npmax = max(unique(npts));
for i = 1:length(rf)
    if length(rf{i}.d) == npmax
        dt = rf{i}.h.delta;
        trf = 0:dt:(npmax*dt);
        trf = trf(1:npmax);
        break
    end
end

% Upsample all data to the maximum sample rate of the dataset
for i = 1:length(rf)
    if rf{i}.h.npts ~= npmax
        rf{i}.t = 0:rf{i}.h.delta:length(rf{i}.d);
        rf{i}.t = rf{i}.t(1:length(rf{i}.d));
        rf{i}.d = interp1(rf{i}.t,rf{i}.d,trf);
        rf{i}.t = trf;
    end
end

% Depth convert and stack receiver functions!

% Depth interval
dz = 0.1;
z = 0:dz:800;

stack = zeros(size(z));

for i = 1:length(rf)
    rf{i}.depth = rfDepcon(rf{i}.d,dt,P(i)/deg2km(1),dz,'iasp91','false');
    stack = stack + rf{i}.depth;
end

stack = stack/length(rf);

% Bootstrap to determine standard deviations
bn = 1000;
bstk = zeros(bn,length(z));

% Resample
for b = 1:bn
    zran = randi(length(rf),[length(rf),1]);
    for i = 1:length(zran)
        bstk(b,:) = bstk(b,:) + rf{zran(i)}.depth;
    end
end

bstk = bstk/length(P);

% Calculate standard deviations
bdot = sum(bstk,1)/bn;
num = zeros(1,length(z));
for b = 1:bn
    num = num + sum((bstk(b,:) - bdot).^2, 1);
end
sdv = (num/(bn-1)).^(1/2);
mbstk = mean(bstk);
pos = mbstk - (2.*sdv);
pos(pos < 0) = 0;
neg = mbstk + (2.*sdv);
neg(neg > 0) = 0;

% Make a plot of the stack and additional statistics
for i = 1:length(rf_0)
    % Save statistics as vectors
    mag(i,1) = rf_0{i}.h.mag;
    gcarc(i,1) = rf_0{i}.h.gcarc;
    nu(i,1) = rf_0{i}.h.user(4);
    fit(i,1) = rf_0{i}.h.user(3);
end
nbins = [20 20];
H1 = [fit, nu];
H2 = [gcarc, mag];
mygray = flipud(gray);
mygray(2:end,:) = mygray(2:end,:)*0.95;
end