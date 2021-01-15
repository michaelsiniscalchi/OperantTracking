function data_out = catDLCData(data_in)

%Get fieldnames at each level of the struct hierarchy (eg data.body.x)
fields1 = fieldnames(data_in);
fields2 = fieldnames(data_in(1).(fields1{1}));

%Initialize output struct
data_out = struct;
for j = 1:numel(fields1)
    for k = 1:numel(fields2)
        data_out.(fields1{j}).(fields2{k}) = [];
    end
end

%Concatenate each terminal field
for i = 1:numel(data_in)
    for j = 1:numel(fields1)
        for k = 1:numel(fields2)
            data_out.(fields1{j}).(fields2{k}) =...
                vertcat(data_out.(fields1{j}).(fields2{k}), data_in(i).(fields1{j}).(fields2{k}));
        end
    end
end