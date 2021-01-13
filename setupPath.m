function [ dirs, filenames ] = getPaths()
 
%Get Main Drive, Code, and Data Dirs
dirs = getRoots();
addpath(dirs.code);
dirs.code = fullfile(dirs.code,'OperantTracking');
dirs.data = fullfile(dirs.root,'OperantTracking');

%Summary Files
filenames.laser = 'laserSummary_TAB.mat';
filenames.noLaser = 'noLaserSummary_TAB.mat';
filenames.qLearn = 'qLearn_session_final.mat';
