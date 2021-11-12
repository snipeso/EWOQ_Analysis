
DataPath = 'C:\Users\colas\Desktop\Participants';
TemplateFolder = 'PXX';
SaveCSV = false;
IgnoreFolders = { 'CSVs', 'PXX', 'PXX_sleep'};


T = LoadAllQuestionnaires(DataPath, TemplateFolder, SaveCSV, IgnoreFolders);
T = LoadAllQuestionnaires(DataPath, 'PXX_sleep', SaveCSV, IgnoreFolders); % weirdly, Sleep wasn't getting saved



DataPath = 'C:\Users\colas\Desktop\Applicants';
TemplateFolder = 'AXX';
SaveCSV = false;
IgnoreFolders = { 'CSVs', 'AXX', 'AXX_sleep',};


T = LoadAllQuestionnaires(DataPath, TemplateFolder, SaveCSV, IgnoreFolders);
T = LoadAllQuestionnaires(DataPath, 'AXX_sleep', SaveCSV, IgnoreFolders);