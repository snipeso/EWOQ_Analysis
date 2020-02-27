function T = CheckData(DataPath, TemplateFolderPath)

% fix stupid backslash problem
TemplateFolderPath = fullfile(TemplateFolderPath, '/', '\');

% get all expected subfolders
Subfolders = dir([TemplateFolderPath, '**/*.*']); % don't know if all the stars are necessary
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


% get all categories
Folders = erase(Subfolders, TemplateFolderPath);
TotCategories = count(Folders, '\') + 1; % might not need




% get all datasets
Datasets =  ls(DataPath);
Datasets(contains(string(Datasets), '.'), :) = []; % remove files and dots

AllFiles = struct();

for Indx_D = 1:size(Datasets, 1)
    Folder_Indx = 1;
    Dataset = deblank(Datasets(Indx_D, :));
    DatasetPath = fullfile(DataPath, Dataset);
    Dataset = matlab.lang.makeValidName(Dataset); 
    
    for Indx_F = 1:numel(Folders)
        Path = fullfile(DatasetPath, Folders{Indx_F});
        
        if ~exist(Path, 'dir')
            warning([deblank(Path), ' does not exist'])
            continue
        end
        
        Levels = split( Folders{Indx_F}, '\');
        for Indx_L = 1:numel(Levels)
           AllFiles(Folder_Indx).(['Level', num2str(Indx_L)]) = Levels{Indx_L}; 
        end
        
        % remove dots
        TotFiles = deblank(string(ls(Path))); 
        TotFiles(strcmp(TotFiles, '.') | strcmp(TotFiles, '..'), :) = [];
        
        AllFiles(Folder_Indx).(Dataset) =size(TotFiles, 1);
%         AllFiles(Folder_Indx).TotFiles = size(TotFiles, 1);
        Folder_Indx = Folder_Indx + 1;
    end
    
end

T = struct2table(AllFiles);
writetable(T, [DataPath, 'AllFiles.csv'])
