
DataPath = 'G:\LSM\Data\Raw';
TemplateFolder = 'PXX_Questionnaires';
SaveCSV = false;
IgnoreFolders = {'Applicants', 'CSVs', 'Lazy', 'P00', 'PXX'};


T = LoadAllQuestionnaires(DataPath, TemplateFolder, SaveCSV, IgnoreFolders);