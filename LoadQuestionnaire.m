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
% allAnswers = struct();
Indx = 1;

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
    
    
    %%% Get question data and answers
    Question = Switchboard(Answers.(ID), Type);
    TotQs = numel(Question);
    if TotQs == 0
        continue
    elseif ~exist('allAnswers', 'var') % create structure with first question
        allAnswers = Question;
        Indx = TotQs+1;
    else % append new data to structure
        EndIndx = Indx+TotQs-1;
        allAnswers(Indx:EndIndx) = Question;
        Indx = EndIndx+1;
    end
    
end

if ~exist('allAnswers', 'var') % if no answers provided, skip
    allAnswers = struct();
end
