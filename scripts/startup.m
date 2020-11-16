%% Let's get it started!
% Last modified 11/12/2020 by aamatya@princeton.edu
cd('/Users/aamatya/Documents/MATLAB/ST2021/scripts');
% Path to MFILES
addpath /Users/aamatya/Desktop/Thesis/MFILES/irisFetch-matlab-2.0.11
% Path to IRIS-WS .jar file
javaaddpath('/Users/aamatya/Desktop/Thesis/JFILES/IRIS-WS-2.0.19.jar')
% Path to open source functions
addpath('/Users/aamatya/Desktop/Thesis');
addpath('/Users/aamatya/Desktop/OpenSourceFunctions');
addpath('/Users/aamatya/Desktop/OpenSourceFunctions/read_kml');
addpath('/Users/aamatya/Desktop/Thesis/plate-boundaries');
addpath('/Users/aamatya/Desktop/OpenSourceFunctions/suplabel');
addpath('/Users/aamatya/Desktop/OpenSourceFunctions/grdread2');
% Load large data
load('events.mat');
load('topography.mat');