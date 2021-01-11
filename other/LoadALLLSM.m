clc
clear
close all

% get common parameters
LSM_Parameters


Overview = struct();
OverviewParticipants = struct();
OverviewQuestionnaires = struct();


MegaTable_Indx = 1;
PIndx = 1;
Participants = getContent(Path.Participants);

% get overview of which questionnaires were done, how long each took

for Indx_P = 1:size(Participants, 1)
    Participant = deblank(Participants(Indx_P, :));
    Path.Participant = [Path.Participants, Participant, '\'];
    Questionnaires = getContent([Path.Participant, '\']);
    OverviewParticipants(PIndx).Name = Participant;
    
    
    OverviewQuestionnaires(PIndx).Name = Participant;
    for Indx_Q = 1:size(Questionnaires, 1)
        Q = Questionnaires(Indx_Q, :);
        
        %         [QuestionnaireName, DateTime]  =  extractFilename(Q);
        QuestionnaireName = deblank(extractAfter(Q, "."));
        QuestionnaireName = ['a', strrep(QuestionnaireName, '-', 'A')];
        DateTime = 1;
        
        % Get questions data
        Path.JSON = [Path.Participant,  deblank(Q), '\'];
        
        %               allAnswers = LoadQuestionnaire('private.json', Path.JSON);
        %  [allAnswers, Eligible] = LoadQuestionnaire('private.json', Path.JSON);
        try
            [allAnswers, JSON] = LoadQuestionnaire('private.json', Path.JSON);
        catch
            warning(['skipped ', Q, ' for ', Participant])
            continue
        end
        
        for Indx_A = 1:size(allAnswers, 2)
            
            Overview(MegaTable_Indx).Questionnaire = QuestionnaireName;
            Overview(MegaTable_Indx).Participant = Participant;
            Overview(MegaTable_Indx).SubmitTime = DateTime;
            Overview(MegaTable_Indx).qID = allAnswers(Indx_A).qID;
            AnswerTime =allAnswers(Indx_A).Time;
            if strcmp(class(AnswerTime), 'datetime')
                Overview(MegaTable_Indx).qTime = allAnswers(Indx_A).Time;
            else
                warning('not a date')
                Overview(MegaTable_Indx).qTime = DateTime;
            end
            Overview(MegaTable_Indx).Question = allAnswers(Indx_A).Question;
            Overview(MegaTable_Indx).qType = allAnswers(Indx_A).Type;
            Overview(MegaTable_Indx).qLabels = allAnswers(Indx_A).Labels;
            Overview(MegaTable_Indx).strAnswer = allAnswers(Indx_A).strAnswer;
            Overview(MegaTable_Indx).numAnswer = allAnswers(Indx_A).numAnswer;
            Overview(MegaTable_Indx).isOK = allAnswers(Indx_A).isOK;
            MegaTable_Indx = MegaTable_Indx + 1;
        end
        OverviewParticipants(PIndx).Date = DateTime;
        OverviewParticipants(PIndx).([QuestionnaireName, '_totAnswers']) = size(allAnswers, 2);
        if contains(QuestionnaireName, 'Screening')
            if isfield(JSON, 'isEligible')
                Eligible = JSON.isEligible;
            else
                Eligible= true;
            end
            OverviewParticipants(PIndx).([QuestionnaireName, '_Eligible']) = [Eligible];
        end
        if contains(QuestionnaireName, 'MCTQ') && isfield(JSON, 'scores')
            OverviewParticipants(PIndx).([QuestionnaireName, '_Score']) = JSON.scores;
        elseif  contains(QuestionnaireName, 'PSQI')  && isfield(JSON, 'scores') && isfield(JSON.scores, 'globalScore')
            OverviewParticipants(PIndx).([QuestionnaireName, '_Score']) = JSON.scores.globalScore;
        end
        
    end
    
    PIndx = PIndx+1;
    
end

AllAnswersT = struct2table(Overview);
writetable(AllAnswersT, [Path.CSV, 'All_Answers.csv'])
save([Path.CSV, 'All_Answers.mat'], 'AllAnswersT')

% TODO: questions summary
SaveSplitTable(AllAnswersT, 'Questionnaire', Path.CSV)



T = struct2table(OverviewParticipants);
writetable(T, [Path.CSV, 'All_Participants.csv'])
save([Path.CSV, 'All_Participants.mat'], 'T')

T = struct2table(OverviewQuestionnaires);
writetable(T, [Path.CSV, 'All_Questionnaires.csv'])
save([Path.CSV, 'All_Questionnaires.mat'], 'T')

function subFolders = getContent(Folder)

subFolders = ls(Folder);
Junk = subFolders(:, 1) == '.' ;

subFolders = subFolders(not(Junk), :);
end
