function newQuestion = extractCoordinates(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct

% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'ImageCoordinates';

Answer = [oldQuestion.data.x, oldQuestion.data.y];
newQuestion.numAnswer = Answer;

newQuestion.Labels = '';