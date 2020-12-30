function [elapsedTime] = eIristime(t1, t2)
% elapsed time in seconds between IRIS formatted times
% last modified 12/29/20 aamatya

% for default IRIS time formatting:
t1 = datevec(t1,'yyyy-mm-ddTHH:MM:SS');
t2 = datevec(t2,'yyyy-mm-ddTHH:MM:SS');

% for elapsed time according to SAC filename:
% function [elapsed time] = eIristime(filename)
    
elapsedTime = etime(t2, t1);
end

