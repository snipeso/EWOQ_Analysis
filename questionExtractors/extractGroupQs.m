function newQuestion = extractGroupQs(oldQuestion)
%%% PROBLEM: didn't save question type


% initialize empty struct
newQuestion = struct();

Tot_Qs = size(oldQuestion.data.allAnswers, 1);

for Indx_Q = 1:Tot_Qs
    Q = oldQuestion.data.allAnswers(Indx_Q)
    
    newQuestion(Indx_Q).Type = 'GroupQuestions';    
    newQuestion(Indx_Q).numAnswer = nan;
    newQuestion(Indx_Q).strAnswer = '';
    
    Q.questionProps
    
    if isfield(Q.questionProps, 'labels')
        newQuestion(Indx_Q).Labels = strjoin(Q.questionProps.labels, '//');
        Answers = Q.questionProps.labels(Q.data.answers);
         newQuestion(Indx_Q).strAnswer = strjoin(Answers, '//');
          newQuestion(Indx_Q).numAnswer = find(Q.data.answers);
    end
    
    
end



%%% needs to spit out struct with  numAnswer, strAnswer, Title,
