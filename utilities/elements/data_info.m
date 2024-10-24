function [path_name, file_base, file_fmt] = data_info
% Select datasets to process
%   Jinghao Lu 01/12/2016

    dfltpth = getpref('MIN1PIPE','imgfiledir',cd);
%     [file_name_tmp, path_name] = uigetfile({'*.tif'; '*.tiff'; '*.avi'}, 'Select coordinates file', 'MultiSelect', 'on');
    [file_name_tmp, path_name] = uigetfile(fullfile(dfltpth,'*'), 'Select imaging file', 'MultiSelect', 'on');
    if isequal(file_name_tmp,0), return; end
    setpref('MIN1PIPE','imgfiledir',path_name);
    if ~iscell(file_name_tmp)
        file_name{1} = file_name_tmp;
    else
        file_name = file_name_tmp;
    end
    
    file_base = cell(1, length(file_name));
    file_fmt = cell(1, length(file_name));
    for i = 1: length(file_name)
        %%% first find out whether it is Inscopix or UCLA %%%
        if contains(file_name{i}, '.avi')
            file_fmt{i} = 'avi';
            %ids = regexp(file_name{i}(1: end - 4), '[^\d]');
            ids = regexp(file_name{i}(1:end-4),'^\d');
            ids = ids(end);
            file_base{i} = file_name{i}(1: ids);
        elseif contains(file_name{i}, '.tiff')
            file_fmt{i} = 'tiff';
            file_temp1 = find(file_name{i} == '-', 1, 'last');
            file_temp2 = find(file_name{i} == '.');
            if ~isempty(file_temp1)
                file_base{i} = file_name{i}(1: file_temp1 - 1);
            else
                file_base{i} = file_name{i}(1: file_temp2 - 1);
            end
        elseif contains(file_name{i}, '.tif')
            file_fmt{i} = 'tif';
            file_temp1 = find(file_name{i} == '-', 1, 'last');
            file_temp2 = find(file_name{i} == '.');
            if ~isempty(file_temp1)
                file_base{i} = file_name{i}(1: file_temp1 - 1);
            else
                file_base{i} = file_name{i}(1: file_temp2 - 1);
            end
        elseif contains(file_name{i}, '.mat')
            file_fmt{i} = 'mat';
            file_temp1 = find(file_name{i} == '-', 1, 'last');
            file_temp2 = find(file_name{i} == '.');
            if ~isempty(file_temp1)
                file_base{i} = file_name{i}(1: file_temp1 - 1);
            else
                file_base{i} = file_name{i}(1: file_temp2 - 1);
            end
        end
    end
end