function newQuestion = extractRadioTable(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct
newQuestion = struct();
Tot_Qs = size(oldQuestion.questionProps.subQuestions);

for Indx_Q = 1:Tot_Qs
    Answer = oldQuestion.data.answers(Indx_Q);
    if isnan(Answer)
        newQuestion(Indx_Q).numAnswer = 0;
    else
        try
            newQuestion(Indx_Q).numAnswer = Answer + 1 ;
              newQuestion(Indx_Q).strAnswer = oldQuestion.questionProps.options{newQuestion(Indx_Q).numAnswer};
        catch
            warning('in radio table, something wrong with answer')
        end
    end
  
    newQuestion(Indx_Q).Title = [oldQuestion.title, ': ', oldQuestion.questionProps.subQuestions{Indx_Q}];
    newQuestion(Indx_Q).Labels = strjoin( oldQuestion.questionProps.options, '//');
    newQuestion(Indx_Q).Type = 'RadioTable';
end