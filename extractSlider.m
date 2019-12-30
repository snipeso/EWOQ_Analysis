function newQuestion = extractSlider(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct

% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'Slider';

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
    warning(['no answer in ', newQuestion.Title])
end
