function newQuestion = extractRadioTable(oldQuestion)
% extracts answers that were in a radio table. Mainly just single number answers
% to multiple possible options.

Tot_Qs = size(oldQuestion.questionProps.subQuestions);

for Indx_Q = 1:Tot_Qs
    
    % create question template
    Q = struct();
    Q.id = [oldQuestion.id, '_rt', num2str(Indx_Q)];
    Q.type = oldQuestion.type;
    Q.title = [oldQuestion.title, ': ', oldQuestion.questionProps.subQuestions{Indx_Q}];
    Q.timestamp = oldQuestion.timestamp;
    
    if Indx_Q == 1
        newQuestion = InitializeQ(Q);
    else
        newQuestion(Indx_Q) = InitializeQ(Q); %#ok<AGROW>
    end
    
    % get answers
    Answer = oldQuestion.data.answers(Indx_Q);
    
    % handle answer types
    if isnan(Answer)
        newQuestion(Indx_Q).numAnswer = 0;
    else
        newQuestion(Indx_Q).numAnswer = Answer + 1; % convert from 0 indexing
        newQuestion(Indx_Q).strAnswer = oldQuestion.questionProps.options{newQuestion(Indx_Q).numAnswer};
    end
    
    newQuestion(Indx_Q).Labels = strjoin(oldQuestion.questionProps.options, '//');
end
