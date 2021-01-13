function dirs = setupPaths()
 
%Get Main Drive and Code Dirs
name = getenv('COMPUTERNAME');
switch name %***EDIT to include current computer name
    case 'homePC'
        dirs.root = fullfile('J:','Data & Analysis');
       
    case 'PNI-F4W2YM2'
        dirs.root = fullfile('C:','Data','OperantTracking');
        dirs.code = fullfile('C:','Users','mjs20','Documents','GitHub','OperantTracking');
end
addpath(dirs.code);

%Summary Files
% filenames.laser = 'laserSummary_TAB.mat';
% filenames.noLaser = 'noLaserSummary_TAB.mat';
% filenames.qLearn = 'qLearn_session_final.mat';
