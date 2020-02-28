function newQuestion = extractRadio(oldQuestion)


% initialize empty struct
newQuestion = struct();
newQuestion.numAnswer = nan;
newQuestion.strAnswer = '';

% get question properties
newQuestion.Title = oldQuestion.title;
newQuestion.Type = 'Radio';

% get answer
Answer  = oldQuestion.data.answer + 1;
extraLabel = oldQuestion.data.extraText;
 
% convert options to one string
Options = oldQuestion.questionProps.options;
Labels = cell([numel(Options), 1]);
for Indx_O = 1:numel(Options)
    try
    Labels{Indx_O} = Options{Indx_O}.text;
    catch
           Labels{Indx_O} = Options(Indx_O).text;
    end
end

newQuestion.Labels = strjoin(Labels, '//');
newQuestion.numAnswer = Answer;

% get answer labels
newQuestion.strAnswer = [Labels{Answer}, ' ', extraLabel];
