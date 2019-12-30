function newQuestion = extractInputGroup(oldQuestion)
% Questions were saved as Q_0: [1x1 struct]. Slider struct is that struct

% initialize empty struct
newQuestion = struct();


Tot_Qs = size(oldQuestion.questionProps.subQuestions, 1);

for Indx_Q = 1:Tot_Qs
    newQuestion(Indx_Q).numAnswer = nan;
    newQuestion(Indx_Q).strAnswer = '';
    try
        newQuestion(Indx_Q).Title = [oldQuestion.title, ' ',oldQuestion.questionProps.subQuestions{Indx_Q}.text ];
    catch
        a= 1
    end
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
            warning(['unexpected case!', inputType])
    end
    
      newQuestion(Indx_Q).Type = inputType;
       newQuestion(Indx_Q).Labels = '';
  
    
end



