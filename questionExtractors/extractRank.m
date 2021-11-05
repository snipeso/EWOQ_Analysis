function newQuestion = extractRank(oldQuestion)
% extracts answers from question where you have to sort items by preference

% create template with basic information
newQuestion = InitializeQ(oldQuestion);

% convert labels list to one string
Labels = oldQuestion.questionProps.cards;
newQuestion.Labels = strjoin(Labels, '//');


% get answer
Answers = oldQuestion.data.answers;
[~, Rank] = ismember(Labels, Answers);

newQuestion.numAnswer = Rank;
newQuestion.strAnswer = strjoin( Answers, '//');
