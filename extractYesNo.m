function newQuestion = extractYesNo(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct

% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'YesNo';

Answer = oldQuestion.data.answer;


switch Answer
    case 'no'
        newQuestion.numAnswer = 0;
    case 'yes'
         newQuestion.numAnswer = 1;
end

newQuestion.strAnswer = Answer;
newQuestion.Labels = '';