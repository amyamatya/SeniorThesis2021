% figure09: epicentral distance

rfdir = ['/Users/aamatya/Documents/MATLAB/ST2021/allCVEvents/RFs'];
rfs = dir(fullfile(rfdir,'*RF.SAC'));
rfNames = {rfs.name};
tLength = 0;
dataLength = 0;
for i = 1:length(rfNames)
    [t, data, hdr] = fread_sac(fullfile(rfdir, char(rfNames(i))));
    if length(t)>maxLength
        tLength = length(t);
    else
        t(length(t)+1:tLength) = NaN;        
    end
    
    if length(data)>dataLength
        dataLength=length(data);
    else
        data(length(data)+1:dataLength) = NaN;
    end
    
    theDists(i) = hdr.gcarc;
    theData(:,i) = data;
    theTimes(:,i) = t;
end
