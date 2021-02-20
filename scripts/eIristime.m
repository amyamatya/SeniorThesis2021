function [elapsedTime] = eIristime(t1, t2)
% elapsed time in seconds between IRIS formatted times
% last modified 12/29/20 aamatya
%---------Input Variables------------------------
% t1, t2            - ex. '2017-07-0312:03:03'
%------------------------------------------------
% for default IRIS time formatting:
t1 = datevec(t1,'yyyy-mm-ddTHH:MM:SS');
t2 = datevec(t2,'yyyy-mm-ddTHH:MM:SS');
elapsedTime = etime(t2, t1);
end