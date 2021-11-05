function newQuestion = extractSlider(oldQuestion)
% Extracts data from questions using sliders. Primarily provides a number
% answer, but if a radio question was also added, this is included as a
% string. 


% create template with basic information
newQuestion = InitializeQ(oldQuestion);

% convert labels list to one string
newQuestion.Labels = strjoin(oldQuestion.questionProps.labels, '//');

% add radio options if present
if isfield(oldQuestion.questionProps, 'extraRadio')
    newQuestion.Labels = [newQuestion.Labels, '+',  strjoin(oldQuestion.questionProps.extraRadio, '+') ];
end


% get answer
if isfield(oldQuestion.data, 'radioAnswer')
    newQuestion.strAnswer = oldQuestion.data.radioAnswer;
elseif isfield(oldQuestion.data, 'answer')
    newQuestion.numAnswer = oldQuestion.data.answer;
else
    warning(['no answer in ', newQuestion.Question])
end
