%% figure01: topographic/plate boundary map of Cape Verde
% Last modified 2/13/21 by aamatya@princeton.edu
%------------------------------------------------------------------------
drawTopo(1);
hold on
cb = colorbar;
cb.Label.String = 'Elevation (m)';
title('Plate Boundaries');
% print(gcf, '/Users/aamatya/Documents/MATLAB/ST2021/figures/figure01','-dpdf');
% Draw topo and plate maps in same figure
% clfall
% figure(1);
% drawTopo();
% colorbar;
% figure(2);
% drawPlates();
% figlist=get(groot,'Children');
% figlist = flip(figlist);
% newfig=figure;
% tcl=tiledlayout(newfig,'flow');
% for i = 1:numel(figlist)
%     figure(figlist(i));
%     ax=gca;
%     ax.Parent=tcl;
%     ax.Layout.Tile=i;
% end