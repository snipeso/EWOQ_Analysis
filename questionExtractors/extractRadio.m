function newQuestion = extractRadio(oldQuestion)
% Extracts answers from questions with radio answer options; i.e. where
% only 1 final answer is possible. Output is primarily the index
% (converting from 0 indexing to 1 indexing) and the text of the answer.
% There was the possibility of adding extra input, which is saved as a
% string at the end.


% create template with basic information
newQuestion = InitializeQ(oldQuestion);

% get answer
Answer  = oldQuestion.data.answer + 1;
extraLabel = oldQuestion.data.extraText;

% convert options to one string
Options = oldQuestion.questionProps.options;
Labels = cell([numel(Options), 1]);
for Indx_O = 1:numel(Options)
    try % deal with arbitrary formatting when converting JSON -.-
        Labels{Indx_O} = Options{Indx_O}.text;
    catch
        Labels{Indx_O} = Options(Indx_O).text;
    end
end

newQuestion.Labels = strjoin(Labels, '//');
newQuestion.numAnswer = Answer;

% get answer labels
newQuestion.strAnswer = [Labels{Answer}, ' ', extraLabel];
