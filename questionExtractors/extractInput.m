function newQuestion = extractInput(oldQuestion)
% extracts answers from open text fields (or similar). returns either a
% string or number, based on what the field type was. Could also be radio
% options.

% create template with basic information
newQuestion = InitializeQ(oldQuestion);

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
        error(['unexpected case!', inputType])
end

% if radio option was selected instead of inputting text
if isfield(oldQuestion.data, 'radioAnswer')
    Answer = oldQuestion.data.radioAnswer + 1;
    Labels = oldQuestion.questionProps.extraRadio;
    newQuestion.strAnswer = Labels{Answer};
    newQuestion.numAnswer = Answer;
    
    newQuestion.Labels = Labels;
else
    newQuestion.Labels = '';
end



