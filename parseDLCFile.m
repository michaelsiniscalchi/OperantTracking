function data_struct = parseDLCFile( path, filename )

fID = fopen(fullfile(path,filename));

%Get header info (tracked objects and position variables)
nCols = numel(strfind(fgetl(fID),',')); %Read first line and get number of columns
header = textscan(fID,['%*s',repmat('%s',1,nCols)],2,'Delimiter',','); %Get objects (eg 'Scope1') and positions (x,y); '%*s' skips first column (label)
for i = 1:numel(header) %Loop though each object/position_variable)
    bodypart{i} = header{i}{1}; %
    bodypart{i}(bodypart{i}==' ') = '_'; %Remove whitespace for valid field name
    coord{i} = header{i}{2};    %Coordinate variables, eg, 'x', 'y', 'likelihood'
end

%Populate data structure with tracked position data
D = textscan(fID,['%*f',repmat('%f',1,nCols)],'Delimiter',','); %Extract numeric data
for i = 1:numel(bodypart)                           %fields: {tracked bodyparts}
    data_struct.(bodypart{i}).(coord{i}) = D{i};    %subfields: {'x', 'y', 'likelihood'}
end
disp(['parseDLCFile: ' num2str(size(data_struct.(bodypart{i}).(coord{i}),1)) 'frames.'])

