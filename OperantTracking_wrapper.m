clearvars;

%% Analysis Parameters

%Code to execute
params.process_DLC_files = false;
params.calc_motor_vars = true;

%Calculation of Motor Variables
params.motor.smoothingWindow = 1; %In seconds
params.motor.plot_validation = true; %Diagnostic plots

%% Get Main Drive, Code, and Data Dirs
[dirs] = setupPaths; %setupPaths
%**TODO** Function: Analysis params

%% Convert all DLC Data/Load into Structure
if params.process_DLC_files
    %Get filenames for tracking data and corresponding behavior-related matfiles
    subjects = ["101","102","103"]; %Restrict to specified subjects
    [fnames, dirs.data] = fileListDLC(dirs.root,subjects);
    for i=1:numel(fnames.DLC)
        disp(['Parsing ',fnames.DLC{i},'...'])
        data.DLC = parseDLCFile(dirs.root,fnames.DLC{i});
        beh_mat = fullfile(dirs.root, dirs.data{i}, fnames.beh{i});
        data = getBehData(data, beh_mat);
        %Check against behavior data
        disp(['From beh. data:',num2str(size(data.DLC.t,1))])
        %Save
        savename = [fnames.beh{i}(1:end-4),'_DLC.mat'];
        save(fullfile(dirs.root,'Proc Tracking Data',savename),'-struct','data');
    end
    clearvars data
    
    %Do separately for T55, T57, T60 & T63
    subjects = ["T55","T57","T60","T63"];
    [fnames, dirs.data] = fileListDLC2(dirs.root,subjects);
    vidIdx = 1;
    for i = 1:numel(fnames.DLC)
        disp(['Parsing ',fnames.DLC{i},'...'])
        data.DLC(vidIdx) = parseDLCFile(dirs.root,fnames.DLC{i});
        vidIdx = vidIdx+1;
        if i==numel(fnames.beh) || ~strcmp(fnames.beh{i},fnames.beh{i+1}) %If last video in session
            %Concatenate each field within data struct
            data.DLC = catDLCData(data.DLC);
            %Copy relevant beh vars
            beh_mat = fullfile(dirs.root, dirs.data{i}, fnames.beh{i});
            data = getBehData(data, beh_mat);
            %TROUBLESHOOT Discrepancy in one set (T55)---------------------
            disp(['After concatenation:',num2str(size(data.DLC.body.x,1))])
            disp(['From beh. data:',num2str(size(data.DLC.t,1))]) 
            disp('');
            %--------------------------------------------------------------
            %Save
            savename = [fnames.beh{i}(1:end-4),'_DLC.mat'];
            save(fullfile(dirs.root,'Proc Tracking Data',savename),'-struct','data');
            clearvars data
            vidIdx = 1; %reset counter
        end
    end
end %if process_DLC_files

%% Calculate Motor Variables
if params.calc_motor_vars
    %Sample dataset:
    fname = '101E630_TAB_DLC.mat';
    data = load(fullfile(dirs.root,'Proc Tracking Data',fname));
    data = calcLocomotorVars(data, params.motor);
    
end