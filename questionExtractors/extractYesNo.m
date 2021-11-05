function newQuestion = extractYesNo(oldQuestion)
% converts binary choice questions. outputs numAnswer as either no (0) or
% yes (1).

% create template with basic information
newQuestion = InitializeQ(oldQuestion);

Answer = oldQuestion.data.answer;


switch Answer
    case 'no'
        newQuestion.numAnswer = 0;
    case 'yes'
         newQuestion.numAnswer = 1;
end

newQuestion.strAnswer = Answer;