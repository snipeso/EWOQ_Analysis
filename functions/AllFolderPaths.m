function Subfolders = AllFolderPaths(DataPath, TemplateFolder, isFullPath)
% DataPath should indicate the folder where all the datasets are.
% TemplateFolder indicates the name of the folder that has the template
% folder structure.
% isFullPath is a boolean indicating whether to include the initial part (e.g. 'C://user/etc'),
% or just the folder structure within the dataset.

TemplateFolderPath = fullfile(DataPath, TemplateFolder);
Subfolders = dir(fullfile(TemplateFolderPath, '**/*.*'));
Subfolders = unique({Subfolders.folder}');

% get only terminating paths
Metafolders = [];
for Indx_S = 1:numel(Subfolders)
    Path = Subfolders{Indx_S};
    
    % skip if the path is not a terminating path
    if nnz(cell2mat(strfind(Subfolders, Path))) > 1
        Metafolders(end + 1) = Indx_S;
    end
end
Subfolders(Metafolders) = [];

% remove initial part of folder path
if ~isFullPath
    Subfolders =  erase(Subfolders, TemplateFolderPath);
end