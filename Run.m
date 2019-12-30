
Filepath = 'C:\Users\colas\Projects\LSMsite\LSM\digestion-drift-abuses\2019-11-25T08_57_24.106145-Screening-Sleep\';
Filename = 'private.json';
[allAnswers, Eligible, JSON] = LoadQuestionnaire(Filename, Filepath);

T = struct2table(allAnswers);
T
