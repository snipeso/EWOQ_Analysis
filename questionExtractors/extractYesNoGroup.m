function newQuestion = extractYesNoGroup(oldQuestion)
% extract answers from a group of yes/no questions

Tot_Qs = size(oldQuestion.questionProps.subQuestions);

for Indx_Q = 1:Tot_Qs
    
    % create question template
    Q = struct();
    Q.id = [oldQuestion.id, '_yn', num2str(Indx_Q)];
    Q.type = oldQuestion.type;
    Q.title = [oldQuestion.title, ': ', oldQuestion.questionProps.subQuestions{Indx_Q}];
    Q.timestamp = oldQuestion.timestamp;
    
    if Indx_Q == 1
        newQuestion = InitializeQ(Q);
    else
        newQuestion(Indx_Q) = InitializeQ(Q); %#ok<AGROW>
    end
    
    % get answers
    Answer = oldQuestion.data.answers{Indx_Q};
    
    switch Answer
        case 'no'
            newQuestion(Indx_Q).numAnswer = 0;
        case 'yes'
            newQuestion(Indx_Q).numAnswer = 1;
    end
    
    newQuestion(Indx_Q).strAnswer = Answer;
    newQuestion(Indx_Q).Labels = '';

end
