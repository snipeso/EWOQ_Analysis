function newQuestion = extractSliderGroup(oldQuestion)


Slider_tot = size(oldQuestion.questionProps, 1);
for Indx_S = 1:Slider_tot
    
    % create question template
    Q = struct();
    Q.type = oldQuestion.type;
    Q.id = [oldQuestion.id, '_sl', num2str(Indx_S)];
    Q.title = oldQuestion.title;
    Q.timestamp = oldQuestion.timestamp;
    
    if Indx_S == 1
        newQuestion = InitializeQ(Q);
    else
        newQuestion(Indx_S) = InitializeQ(Q); %#ok<AGROW>
    end

    
    % get question properties
    newQuestion(Indx_S).Type = 'SliderGroup';
    
    try % sometimes the format changes :/
        if isfield(oldQuestion.questionProps{Indx_S}, 'question')
            subTitle= ['-', oldQuestion.questionProps{Indx_S}.question];
        else
            subTitle = '';
        end
        if isfield(oldQuestion.questionProps{Indx_S}, 'labels')
            Labels= strjoin(oldQuestion.questionProps{Indx_S}.labels, '/');
            
        else
            Labels = '';
        end
    catch %% because the thing gets saved differently
        if isfield(oldQuestion.questionProps, 'question') % TODO, check that this is what its called
            subTitle= ['-', oldQuestion.questionProps(Indx_S).question];
        else
            subTitle = '';
        end
        if isfield(oldQuestion.questionProps, 'labels') % TODO, check that this is what its called
            Labels= strjoin( oldQuestion.questionProps(Indx_S).labels, '/');
            
            
        else
            Labels = '';
        end
    end
    
    newQuestion(Indx_S).Question = [newQuestion(Indx_S).Question, subTitle];
    newQuestion(Indx_S).Labels = Labels;
    newQuestion(Indx_S).numAnswer = oldQuestion.data.answers(Indx_S);
    
end
