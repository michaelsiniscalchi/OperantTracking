
clearvars;
%% INITIALIZE MATLAB PATH

%***Function: getMainDrive()***

addpath(fullfile('J:','Documents','GitHub','OperantTracking'));
datapath = 'J:\Documents\GitHub\OperantTracking\101';
% datapath = fullfile('Z:','Michael','Tracking Analysis for JC'); %\\bucket\witten\Michael\Tracking Analysis for JC

%Load summary file for subject
fname.laser = 'laserSummary_TAB.mat';
fname.noLaser = 'noLaserSummary_TAB.mat';
fname.tracking = '101_e630_tab_20200630_151125DLC_resnet50_ACC_DMS_imaging_skelOct1shuffle1_450000.csv';

% fname.tracking = getSessionInfo(subject);

laser = load(fullfile(datapath, fname.laser));
noLaser = load(fullfile(datapath, fname.noLaser));
data = struct('laser',laser.data,'noLaser',noLaser.data);

%Load tracking data for each session
data.tracking = parseDLCFile(datapath,fname.tracking);
