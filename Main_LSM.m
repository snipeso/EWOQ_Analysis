
DataPath = 'G:\LSM\Data\Raw';
TemplateFolder = 'PXX';
SaveCSV = false;
IgnoreFolders = {'Applicants', 'CSVs', 'Lazy', 'P00'};


T = LoadAllQuestionnaires(DataPath, TemplateFolder, SaveCSV, IgnoreFolders);