function newQuestion = extractGroupQs(oldQuestion)
%%% PROBLEM: didn't save question type


% initialize empty struct
% newQuestion = struct();

Tot_Qs = size(oldQuestion.data.allAnswers, 1);

Indx = 1;

for Indx_Q = 1:Tot_Qs
    Q = oldQuestion.data.allAnswers(Indx_Q);
    
    Q.id = [oldQuestion.id, '_', Q.id];
    Q.title = [oldQuestion.title, ': ', Q.title];
    
    Type = Q.type;
    
    try
        newQ =  Switchboard(Q, Type);
        TotQs = numel(newQ); % takes into account that there can be sub-questions
        EndIndx = Indx+TotQs-1;
        newQuestion(Indx:EndIndx) =newQ;
    catch
        a=1;
    end
    
    Indx = EndIndx + 1;
    
end