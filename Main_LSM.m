
DataPath = 'G:\LSM\Data\Raw';
TemplateFolder = 'PXX_Questionnaires';
SaveCSV = false;
IgnoreFolders = {'Applicants', 'Uncertain', 'CSVs', 'Lazy', 'P00', 'PXX'};


T = LoadAllQuestionnaires(DataPath, TemplateFolder, SaveCSV, IgnoreFolders);