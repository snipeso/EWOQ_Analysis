function newQuestion = extractMultipleChoice(oldQuestion)


% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'MultipleChoice';

% get answers
Answers  = find(oldQuestion.data.answers)';
extraLabels = oldQuestion.data.extraTexts;
 
% convert options to one string
Tot_Options = numel(oldQuestion.questionProps.options);
Labels = cell([Tot_Options, 1]);
for Indx_O = 1:Tot_Options
    try
    Labels{Indx_O} = oldQuestion.questionProps.options{Indx_O}.text;
    catch
        Labels{Indx_O} = oldQuestion.questionProps.options(Indx_O).text;
    end
    
    % add extra text if they provided it
    if intersect(Answers, Indx_O) & extraLabels{Indx_O}  %#ok<AND2>
        Labels{Indx_O} = [Labels{Indx_O}, '+',  extraLabels{Indx_O}];
    end
    
end

newQuestion.Labels = strjoin(Labels, '//');
newQuestion.numAnswer = Answers;

% get answer labels
newQuestion.strAnswer = strjoin(Labels(Answers), '//');
