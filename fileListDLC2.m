%Same as fileListDLC() but for sessions requiring concatenation

function [ file_name, data_dir ] = fileListDLC2( DLC_dir, subjects )

%Get filenames for all DLC CSV files, restricted by subject
for i = 1:numel(subjects)
    flist = dir(fullfile(DLC_dir,strcat(subjects(i),'*.csv')));
    fnames{i,:} = {flist.name}';
end
fnames = cat(1,fnames{:});

%Hardcode the filename of each behavior matfile
for i = 1:numel(fnames)
    C = textscan(fnames{i},'%s',3,'Delimiter','_');
    switch C{1}{1}
        case'T55'
            file_name.beh{i,:} = 'T55E624_TAB.mat';  %Format is '101_e630_tab_...csv' for beh file: 101E630_TAB
        case'T57'
            file_name.beh{i,:} = 'T57E625_TAB.mat';
        case'T60'
            file_name.beh{i,:} = 'T60E625_TAB.mat';
        case'T63'
            file_name.beh{i,:} = 'T63E624_TAB.mat';
    end
    data_dir(i,:) = C{1}(1);
end
file_name.DLC = fnames;
