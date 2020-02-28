# EWOQ_Analysis
Matlab scripts for reading EWOQ questionnaires into tables


## How to use
`LoadAllQuestionnaires()` goes through all the folders where you've saved data, looks for questionnaires ('private.json'), and saves them to a table structure. Questionnaires will be grouped by the name of the last folder in which the questionnaire was found (unless it was 'questionnaire', in which case it takes the second to last). So if you have data saved such that: P01>Session1>Questionnaires>KSS>{superlongquestionnairefoldernamewithtimestamp}>private.json, the questionnaire will be saved as 'KSS.csv', and will have all the questionnaire answers that came in folders called KSS. 

Get all questionnaire answers into a table: `T = LoadAllQuestionnaires('C:\Users\colas\Desktop\FakeData\', 'PXX', true, {'other'});`
* provide the dataset folder containing datasets
* provide folder (saved inside the data folder) with the template structure. This is so the program only looks in "sanctioned" folders, and is consistent across datasets.
* indicate with true or false if you want to save CSVs of individual questionnaires (inside their respective folders)
* provide a cell list of other folders inside the dataset folder that are not part of the dataset; these will be ignored



`CheckData()` goes through all the folders in all the datasets based on a template, and returns a table indicating how many files are in each destination. This is to easily spot where there's misssing data.

Get all files in data folders: `T = CheckData('C:\Users\colas\Desktop\FakeData\', 'PXX', {'other'})`


