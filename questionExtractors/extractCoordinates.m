function newQuestion = extractCoordinates(oldQuestion)
% extracts information from question that required to click on an image (a
% map).

% create template with basic information
newQuestion = InitializeQ(oldQuestion);

Answer = [oldQuestion.data.x, oldQuestion.data.y];
newQuestion.numAnswer = Answer;
