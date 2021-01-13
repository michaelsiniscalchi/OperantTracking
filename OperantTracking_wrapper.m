clearvars;

%% Get Main Drive, Code, and Data Dirs
[dirs, fnames] = setupPaths; %setupPaths
% sessions = getSessionInfo(dirs);

%% Convert all DLC Data/Load into Structure
fnames.tracking = fileListDLC(); %Stored filenames for tracking data; or maybe just grab all
data.tracking = parseDLCFile(datapath,fnames.tracking);

%Do separately for T55, T57, T60 & T63
fnames.tracking = fileListDLC2(dirs);
data.tracking = parseDLCFile(datapath,fnames.tracking);

%Save each struct in MAT for tracking analysis

%% Analyze Tracking Data
%Load tracking data for each session
% [fnames, matfiles] = getSessionInfo(dirs,fnames);

