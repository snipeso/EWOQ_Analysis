function newQuestion = extractInput(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct

% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'TypeInput';

inputType = oldQuestion.questionProps.inputType;
Answer = oldQuestion.data.text;

switch inputType
    case 'string'
        newQuestion.strAnswer = Answer;
        
        
    case 'number'
        newQuestion.numAnswer = str2double(Answer);
    case 'time'
        newQuestion.strAnswer = Answer;
    otherwise
        warning(['unexpected case!', inputType])
end

if isfield(oldQuestion.data, 'radioAnswer')
    Answer = oldQuestion.data.radioAnswer + 1;
    Labels = oldQuestion.questionProps.extraRadio;
    newQuestion.strAnswer = Labels{Answer};
    newQuestion.numAnswer = Answer;
    
    newQuestion.Labels = Labels;
else
    newQuestion.Labels = '';
end



