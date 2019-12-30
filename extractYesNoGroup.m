function newQuestion = extractYesNoGroup(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct
    newQuestion = struct();
Tot_Qs = size(oldQuestion.questionProps.subQuestions);

for Indx_Q = 1:Tot_Qs
    
    % initialize empty struct

    newQuestion(Indx_Q).numAnswer = nan;
    newQuestion(Indx_Q).strAnswer = '';
    
    % get question properties
    newQuestion(Indx_Q).Title = [oldQuestion.title, ': ', oldQuestion.questionProps.subQuestions{Indx_Q}];
    newQuestion(Indx_Q).Type = 'YesNoGroup';
    
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