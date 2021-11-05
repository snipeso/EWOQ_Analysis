function newQuestion = extractSliderGroup(oldQuestion)


Tot_Qs = size(oldQuestion.questionProps, 1);
for Indx_Q = 1:Tot_Qs
    
    % create question template
    Q = struct();
    Q.type = oldQuestion.type;
    Q.id = [oldQuestion.id, '_sl', num2str(Indx_Q)];
    Q.title = oldQuestion.title;
    Q.timestamp = oldQuestion.timestamp;
    
    if Indx_Q == 1
        newQuestion = InitializeQ(Q);
    else
        newQuestion(Indx_Q) = InitializeQ(Q); %#ok<AGROW>
    end

    
    % get question properties
    newQuestion(Indx_Q).Type = 'SliderGroup';
    
    try % sometimes the format changes :/
        if isfield(oldQuestion.questionProps{Indx_Q}, 'question')
            subTitle= ['-', oldQuestion.questionProps{Indx_Q}.question];
        else
            subTitle = '';
        end
        if isfield(oldQuestion.questionProps{Indx_Q}, 'labels')
            Labels= strjoin(oldQuestion.questionProps{Indx_Q}.labels, '/');
            
        else
            Labels = '';
        end
    catch %% because the thing gets saved differently
        if isfield(oldQuestion.questionProps, 'question') % TODO, check that this is what its called
            subTitle= ['-', oldQuestion.questionProps(Indx_Q).question];
        else
            subTitle = '';
        end
        if isfield(oldQuestion.questionProps, 'labels') % TODO, check that this is what its called
            Labels= strjoin( oldQuestion.questionProps(Indx_Q).labels, '/');
            
            
        else
            Labels = '';
        end
    end
    
    newQuestion(Indx_Q).Question = [newQuestion(Indx_Q).Question, subTitle];
    newQuestion(Indx_Q).Labels = Labels;
    newQuestion(Indx_Q).numAnswer = oldQuestion.data.answers(Indx_Q);
    
end
