function newQuestion = extractRank(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct

% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'RankList';

% convert labels list to one string
Labels = oldQuestion.questionProps.cards;
newQuestion.Labels = strjoin(Labels, '//');


% get answer
Answers = oldQuestion.data.answers;
[~, Rank] = ismember(Labels, Answers);

newQuestion.numAnswer = Rank;
newQuestion.strAnswer = strjoin( Answers, '//');
