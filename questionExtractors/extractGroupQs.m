function newQuestion = extractGroupQs(oldQuestion)
% dangerous recursive function that, when receiving a group question, goes
% into it, and saves the questions as if they were individual questions.

if isfield(oldQuestion, 'data')
    Tot_Qs = size(oldQuestion.data.allAnswers, 1);
else
    warning(['no answer for ',oldQuestion.id])
    newQuestion = [];
    return
end

Indx = 1;

for Indx_Q = 1:Tot_Qs
    Q = oldQuestion.data.allAnswers(Indx_Q);
    
    if iscell(Q) % deal with weird conversion from JSON
        Q = Q{1};
    end
    
    
    Q.id = [oldQuestion.id, '_gq', Q.id];
    Q.title = [oldQuestion.title, ': ', Q.title];
    
    if isfield(Q, 'type')
        Type = Q.type;
    else
        Q.timestamp = oldQuestion.timestamp;
        Q.data.answer = []; % hack to trick switchboard that the question was skipped; maybe TODO fix
        Type = '';
    end
    
    
    % get question formatted correctly
    newQ =  Switchboard(Q, Type);
    
    % add question or group of questions to the list
    TotQs = numel(newQ); % takes into account that there can be sub-questions
    EndIndx = Indx+TotQs-1;
    newQuestion(Indx:EndIndx) =newQ;
    
    Indx = EndIndx + 1;
    
end
