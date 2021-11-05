function newQuestions = repeatGroupQuestions(oldQuestion)
% loops through multiple groupQuestions blocks.

TotClusters = numel(oldQuestion.data.clusters);

Indx = 1;
for Indx_C = 1:TotClusters
    C = oldQuestion.data.clusters(Indx_C);
    
    if iscell(C) % deal with weird conversion from JSON
        if numel(C) > 1
            a = 1;
        end
        C = C{1};
    end
    
    C.id = oldQuestion.id;
    
    C.title = oldQuestion.title;
    C.timestamp = oldQuestion.timestamp;
    
    if ~exist('newQuestions', 'var')
        newQ = extractGroupQs(C);
        if ~isempty(newQ)
            newQuestions = newQ;
        end
    else
        newQ = extractGroupQs(C);
        TotQ = numel(newQ);
        
        if ~isempty(newQ)
            newQuestions(Indx:Indx+TotQ-1) = newQ;
            Indx = Indx+TotQ;
        end
    end
end
