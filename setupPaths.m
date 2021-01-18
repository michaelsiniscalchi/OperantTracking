function dirs = setupPaths()
 
%Get Main Drive and Code Dirs
name = getenv('COMPUTERNAME');
switch name %***EDIT to include current computer name
    case 'STELLATE'
        dirs.root = fullfile('J:','Data & Analysis','OperantTracking');
        dirs.code = fullfile('J:','Documents','GitHub','OperantTracking');
    case 'PNI-F4W2YM2'
        dirs.root = fullfile('C:','Data','OperantTracking');
        dirs.code = fullfile('C:','Users','mjs20','Documents','GitHub','OperantTracking');
end
addpath(dirs.code);

%Summary Files
% filenames.laser = 'laserSummary_TAB.mat';
% filenames.noLaser = 'noLaserSummary_TAB.mat';
% filenames.qLearn = 'qLearn_session_final.mat';
