function newQuestion = extractInputGroup(oldQuestion)
% Extracts answers input gorup questions.

Tot_Qs = size(oldQuestion.questionProps.subQuestions, 1);

for Indx_Q = 1:Tot_Qs
    
    % create question template
    Q = struct();
    Q.id = [oldQuestion.id, '_ig', num2str(Indx_Q)];
    Q.type = oldQuestion.type;
    Q.title = [oldQuestion.title, '; ', oldQuestion.questionProps.subQuestions{Indx_Q}.text];
    Q.timestamp = oldQuestion.timestamp;
    
    if Indx_Q == 1
        newQuestion = InitializeQ(Q);
    else
        newQuestion(Indx_Q) = InitializeQ(Q); %#ok<AGROW>
    end
    
    % get answers
    inputType = oldQuestion.questionProps.subQuestions{Indx_Q}.inputType;
    
    Answer = oldQuestion.data.answers{Indx_Q};
    
    switch inputType
        case 'string'
            newQuestion(Indx_Q).strAnswer = Answer;
        case 'number'
            newQuestion(Indx_Q).numAnswer = str2double(Answer);
        case 'time'
            newQuestion(Indx_Q).strAnswer = Answer;
        otherwise
            error(['unexpected case!', inputType])
    end
end