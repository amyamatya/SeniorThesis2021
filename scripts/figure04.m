
% pre open storage for tr
% 10%
for i = randi(length(quakes.mag), 10,1)
    i
%     convert time
    tr(i).quake = irisFetch.Traces(network,station,location, channel, quakes.time{i}, endtime(i));
end