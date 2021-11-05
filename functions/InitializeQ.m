function newQuestion = InitializeQ(oldQuestion)
% creates standard question template:
% Q.qID = old ID for that question
% Q.Time = timestamp of question
% Q.Type = question type
% Q.Question = plain question text
% Q.Labels = string with all the labels of the question (if exists)
% Q.strAnswer = string answer (if exists)
% Q.numAnswer = numerical answer (if exists)
% Q.isOK = especially for screening questionnaire, saved info on whether
% the question was considered ok.

% initialize struct
newQuestion = struct();


% get question properties
newQuestion.qID = oldQuestion.id;
newQuestion.Time = ConvertTime(oldQuestion.timestamp);

newQuestion.Type = oldQuestion.type;
newQuestion.Question = oldQuestion.title;
newQuestion.Labels = '';

newQuestion.strAnswer = '';
newQuestion.numAnswer = nan;


if isfield(oldQuestion, 'isOk')
    newQuestion.isOK = oldQuestion.isOk;
else
    newQuestion.isOK = nan;
end

end


function NewTime = ConvertTime(OldTime)
% convert the timestamps to zurich time

NewTime = datenum(OldTime,'yyyy-mm-ddTHH:MM:SS'); % convert to absolute number
NewTime = datetime(NewTime, 'ConvertFrom','datenum', 'TimeZone', 'UTC'); % convert to legibile format
NewTime.TimeZone = 'Europe/Zurich'; % set time zone to Zurich. NOTE: the questionnaire saves the timestamp as UTC

end