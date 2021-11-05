function newQuestion = extractGroupQs(oldQuestion)
% dangerous recursive function that, when receiving a group question, goes
% into it, and saves the questions as if they were individual questions.

Tot_Qs = size(oldQuestion.data.allAnswers, 1);

Indx = 1;

for Indx_Q = 1:Tot_Qs
    Q = oldQuestion.data.allAnswers(Indx_Q);
    
    Q.id = [oldQuestion.id, '_', Q.id];
    Q.title = [oldQuestion.title, ': ', Q.title];
    
    Type = Q.type;
    
    % get question formatted correctly
    newQ =  Switchboard(Q, Type);
    
    % add question or group of questions to the list
    TotQs = numel(newQ); % takes into account that there can be sub-questions
    EndIndx = Indx+TotQs-1;
    newQuestion(Indx:EndIndx) =newQ;
    
    Indx = EndIndx + 1;
    
end
