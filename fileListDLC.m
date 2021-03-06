function [ file_name, data_dir ] = fileListDLC( DLC_dir, subjects )

%Get filenames for all DLC CSV files, restricted by subject
for i = 1:numel(subjects)
    flist = dir(fullfile(DLC_dir,strcat(subjects(i),'*.csv')));
    fnames{i,:} = {flist.name}';
end
fnames = cat(1,fnames{:});

%Infer the filename of each behavior matfile
for i = 1:numel(fnames)
    C = textscan(fnames{i},'%s',3,'Delimiter','_');
    file_name.beh{i,:} = [strjoin(C{1}(1:2),''),'_',C{1}{3},'.mat']; %Format is '101_e630_tab_...csv' for beh file: 101E630_TAB
    data_dir(i,:) = C{1}(1);
end
file_name.DLC = fnames;
