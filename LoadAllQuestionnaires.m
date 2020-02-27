function T = LoadAllQuestionnaires(DataPath, TemplateFolder, SaveCSV)


% make path for CSV destinations
CSVFolder = fullfile(DataPath, 'CSVs');
if ~exist(CSVFolder, 'dir')
    mkdir(CSVFolder)
end


% fix stupid backslash problem
TemplateFolderPath = fullfile(DataPath, TemplateFolder);

% get all expected subfolders
Subfolders = dir(fullfile(TemplateFolderPath, '**/*.*')); % if this breaks, it's because you didn't end the path with \
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


% get all datasets
Datasets =  ls(DataPath);
Datasets(contains(string(Datasets), '.'), :) = []; % remove files and dots
Datasets(contains(string(Datasets), TemplateFolder), :) = []; % ignores template structure

AllQuestionnaires = struct();

for Indx_D = 1:size(Datasets, 1) % loop through participants
    
    Dataset = deblank(Datasets(Indx_D, :));
    DatasetPath = fullfile(DataPath, Dataset);
    Dataset = matlab.lang.makeValidName(Dataset);
    
    for Indx_F = 1:numel(Folders)
        
        % estimate folder destination for each dataset based on template
        Path = fullfile(DatasetPath, Folders{Indx_F});
        Levels = split(Folders{Indx_F}, '\');
        Levels(cellfun('isempty',Levels)) = []; % remove blanks
        Levels(strcmpi(Levels, 'questionnaire') | strcmpi(Levels, 'questionnaires')) = []; % remove uninformative level that its a questionnaire
        
        % skip rest if folder not found
        if ~exist(Path, 'dir')
            warning([deblank(Path), ' does not exist'])
            continue
        end
        
        
        
        % see if content is a folder (or exceptionnaly a json file?)
        
        Content = dir(Path);
        Content(~[Content.isdir]) = []; % remove files from list
        
        for Indx_C = 1:size(Content, 1) % loop through possible subfolders
            
            % check if there's a private json
            Subpath = fullfile(Content(Indx_C).folder, Content(Indx_C).name);
            Subcontent = ls(Subpath);
            if ~any(contains(string(Subcontent), 'private.json'))
                continue
            end
            
            % Use last folder as questionnaire identifier, unless folder is
            % named "questionnaire", then use the one before that
            QName = Levels{end};
            
            % download questionnaire
            allAnswers = LoadQuestionnaire(fullfile(Subpath, 'private.json'));
            
            
            % load all questions to questionnaire structure
            for Indx_A = 1:size(allAnswers, 2)
                
                if isfield(AllQuestionnaires, QName)
                    % add questions to struct
                    Q_Indx = size(AllQuestionnaires.(QName).questions, 2) + 1;
                else
                    % start a new struct
                    Q_Indx = 1;
                end
                
                % save all folders to question entry
                AllQuestionnaires.(QName).questions(Q_Indx).dataset = Dataset;
                AllQuestionnaires.(QName).questions(Q_Indx).filename = Content(Indx_C).name; % saves folder that defines the questionnaire
                for Indx_L = 1:numel(Levels)
                    AllQuestionnaires.(QName).questions(Q_Indx).(['Level', num2str(Indx_L)]) = Levels{Indx_L};
                end
                
                % save question properties
                AllQuestionnaires.(QName).questions(Q_Indx).qID = allAnswers(Indx_A).qID;
                AllQuestionnaires.(QName).questions(Q_Indx).Question = allAnswers(Indx_A).Question;
                AllQuestionnaires.(QName).questions(Q_Indx).qType = allAnswers(Indx_A).Type;
                AllQuestionnaires.(QName).questions(Q_Indx).qLabels = allAnswers(Indx_A).Labels;
                
                % save answers
                AllQuestionnaires.(QName).questions(Q_Indx).strAnswer = allAnswers(Indx_A).strAnswer;
                AllQuestionnaires.(QName).questions(Q_Indx).numAnswer = allAnswers(Indx_A).numAnswer;
            end
            
            
            % save questionnaire as csv inside folder
            if SaveCSV
                T = struct2table(allAnswers);
                filename = matlab.lang.makeValidName(Subpath);
                writetable(T, fullfile(Subpath, [filename, '.csv']));
            end
            
        end
        
    end
    
end

% save questionnaires
Questionnaires = fieldnames(AllQuestionnaires);

for Indx_Q = 1:numel(Questionnaires)
    Q = AllQuestionnaires.(Questionnaires{Indx_Q}).questions;
    T = struct2table(Q);
    writetable(T,  fullfile(CSVFolder, [Questionnaires{Indx_Q} '_All.csv']));
end



