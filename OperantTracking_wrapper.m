clearvars;

%% Get Main Drive, Code, and Data Dirs
[dirs] = setupPaths; %setupPaths
% sessions = getSessionInfo(dirs);

%% Convert all DLC Data/Load into Structure
subjects = ["101","102","103"];
[fnames, dirs.data] = fileListDLC(dirs.root,subjects); %Get filenames for tracking data and corresponding behavior-related matfiles

for i=1:numel(fnames.DLC)
    beh = load(fullfile(dirs.root, dirs.data(i), fnames.beh(i)));
    data = parseDLCFile(dirs.root,fnames.DLC(i));
    data.t = beh.data.raw.X';
    data.subject = dirs.data(i);
    savename = char(fnames.beh(i));
    savename = [savename(1:end-4),'_DLC.mat'];
    save(fullfile(dirs.root, savename),'-struct','data');
end

% %Do separately for T55, T57, T60 & T63
% fnames.tracking = fileListDLC2(dirs);
% data.tracking = parseDLCFile(datapath,fnames.tracking);
% 
% %Save each struct in MAT for tracking analysis
% 
% %% Analyze Tracking Data
% %Load tracking data for each session
% % [fnames, matfiles] = getSessionInfo(dirs,fnames);

