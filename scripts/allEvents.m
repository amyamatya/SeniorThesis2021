function [sacvEvents, sacvEventsOut] = allEvents()
% Get, store, save all events starting 05/29/2000 magnitudes 3-9
% last modified 2/17/21 @aamatya
%---------Output Variables------------------
% sacvEvents            - event magnitude, location, depth, time within retrieval range
% sacvEventsOut         - " outside retrieval range
%-------------------------------------------
% Get events inside donut
[~, sacvEvents] = getEvents('SACV',30, 90, 3, 9);
% Get events outside donut
[~, sacvEventsOut] = getEvents('SACV',0, 30, 3, 9);
[~, sacvEventsOutOut] = getEvents('SACV',90, 180, 3, 9);
% Join non-donut data
sacvEventsOut = [sacvEventsOut sacvEventsOutOut];
fn = fieldnames(sacvEventsOut);
for i=1:numel(fn)
    temp.(fn{i}) = [sacvEventsOut(1).(fn{i})' sacvEventsOut(2).(fn{i})'];
    temp.(fn{i}) = temp.(fn{i})';
end
clear sacvEventsOut sacvEventsOutOut
sacvEventsOut = temp;
save('/Users/aamatya/Documents/MATLAB/files/allSacvEvents.mat');
end