function [allAnswers, JSON] = LoadQuestionnaire(filepath)
% gets questionnaire answers.
% filepath should be like:
% 'C:\\user\FakeData\P01\Questionnaire\{longnamewithtimestamp}\private.json'.
% Use 'fullfile()' to make sure path is correct.

% locate scripts for different question types
addpath(fullfile(cd, 'questionExtractors'))

% read JSON
JSON = jsondecode(fileread(filepath));
if isfield(JSON, 'answers')
    Answers = JSON.answers;
    
elseif isfield(JSON, 'isHonest') % TODO: remove eventually
    
    allAnswers.qID = 'honesty';
    allAnswers.Time = '';
    allAnswers.Type = 'Honesty';
    allAnswers.Labels = '';
    allAnswers.isOK =  1;
    allAnswers.Question = 'Honest answers?';
    allAnswers.strAnswer = ''; % in case o extra text, or extra radio button
    allAnswers.numAnswer = JSON.isHonest;
    disp([filepath, ' passed!', ' Honestly?', num2str(JSON.isHonest), '. Done in ', JSON.language])
    return
end

% extract question IDs
Question_IDs = fieldnames(Answers);

% create struct
allAnswers = struct();
newIndx = 1;

for Indx_Q = 1:numel(Question_IDs)
    
    ID = Question_IDs{Indx_Q};
    
    % skip questions that remained hidden
    % TODO: eventually add an entry that indicates this was hidden
    if ~Answers.(ID).wasShown
        continue
    end
    
    % get question type
    try
        Type = Answers.(ID).type;
    catch
        Type = '';
    end
    
    % get time
    Time = datenum(Answers.(ID).timestamp,'yyyy-mm-ddTHH:MM:SS'); % convert to absolute number
    Time = datetime(Time, 'ConvertFrom','datenum', 'TimeZone', 'UTC'); % convert to legibile format
    Time.TimeZone = 'Europe/Zurich'; % set time zone to Zurich. NOTE: the questionnaire saves the timestamp as UTC
    
    
    %%% Get question data and answers
    Question = Switchboard(Answers.(ID), Type);
    if isempty(Question)
        continue
    end
    
    
    %%% handle subquestions
    subQs = size(Question, 2);
    
    for Indx_sQ = 1:subQs
        
        allAnswers(newIndx).qID = ID;
        allAnswers(newIndx).Time = Time;
        
        allAnswers(newIndx).Question = Question(Indx_sQ).Title;
        allAnswers(newIndx).Type = Question(Indx_sQ).Type;
        allAnswers(newIndx).Labels = Question(Indx_sQ).Labels;
        
        allAnswers(newIndx).strAnswer = Question(Indx_sQ).strAnswer;
        allAnswers(newIndx).numAnswer = Question(Indx_sQ).numAnswer;
        allAnswers(newIndx).isOK =  Answers.(ID).isOk;
        
        newIndx = newIndx + 1;
    end
end
end



