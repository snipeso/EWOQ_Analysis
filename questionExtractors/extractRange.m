function newQuestion = extractRange(oldQuestion)
% Extracts information from question type that allows selection of range of
% options.

% create template with basic information
newQuestion = InitializeQ(oldQuestion);

% get answers
Answers  = find(oldQuestion.data.answers)';


% convert options to one string
Tot_Options = numel(oldQuestion.questionProps.labels);
Labels = cell([Tot_Options, 1]);
for Indx_O = 1:Tot_Options
    Labels{Indx_O} = oldQuestion.questionProps.labels{Indx_O};
end

newQuestion.Labels = strjoin(Labels, '//');
newQuestion.numAnswer = Answers;

% get answer labels
newQuestion.strAnswer = strjoin(Labels(Answers), '//');
