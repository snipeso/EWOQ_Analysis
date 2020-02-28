function [allAnswers, JSON] = LoadQuestionnaire(filepath)
%%% gets questionnaire answers.
%%% filename should be like "filename.json"
%%% filepath should be like "C:\AllData\Questionnaires\Participant0\"
%%% view is a boolean, set to true if you want the output printed to the
%%% command window.
%%% savetable is a boolean that can save the output to a .csv

addpath(fullfile(cd, 'questionExtractors'))

% read JSON
JSON = jsondecode(fileread(filepath));
if isfield(JSON, 'answers')
    Answers = JSON.answers;

    
elseif isfield(JSON, 'isHonest')
    
    allAnswers.qID = 'honesty';
    allAnswers.Time = '';
    
    allAnswers.Type = 'Honesty';
    allAnswers.Labels = '';
    
    
    allAnswers.isOK =  1;
    
    allAnswers.Question = 'Honest answers?';
    allAnswers.strAnswer = ''; % in case o extra text, or extra radio button
    allAnswers.numAnswer = JSON.isHonest;
%     eligible =false;
    disp([filepath, ' passed!', ' Honestly?', num2str(JSON.isHonest), '. Done in ', JSON.language])
    return
else
    A = 1
end

% extract question IDs
Question_IDs = fieldnames(Answers);

% create struct
allAnswers = struct();
newIndx = 1;

for Indx_Q = 1:numel(Question_IDs)
    
    ID = Question_IDs{Indx_Q};
    
    if Answers.(ID).wasShown
        try
            Type = Answers.(ID).type;
        catch
            Type = '';
        end
        
        % get time
        Time = datenum(Answers.(ID).timestamp,'yyyy-mm-ddTHH:MM:SS'); % convert to absolute number
        Time = datetime(Time, 'ConvertFrom','datenum', 'TimeZone', 'UTC'); % convert to legibile format
        Time.TimeZone = 'Europe/Zurich';
        % change timezone from Zulu time (London) to Zurich
        
        
        % Get question data and answers
        switch Type
            case 'Slider'
                Question = extractSlider(Answers.(ID));
            case 'SliderGroup'
                Question = extractSliderGroup(Answers.(ID));
            case 'MultipleChoice'
                Question = extractMultipleChoice(Answers.(ID));
            case 'Radio'
                Question = extractRadio(Answers.(ID));
            case 'RadioTable'
                Question = extractRadioTable(Answers.(ID));
            case 'YesNo'
                Question = extractYesNo(Answers.(ID));
            case 'YesNoGroup'
                Question = extractYesNoGroup(Answers.(ID));
            case 'TypeInput'
                Question = extractInput(Answers.(ID));
            case 'TypeInputGroup'
                Question = extractInputGroup(Answers.(ID));
            case 'Range'
                Question = extractRange(Answers.(ID));
                
            case 'ImageCoordinates'
                Question = extractCoordinates(Answers.(ID));
            case ''
                if isfield( Answers.(ID).data, 'answer')
                    Question = struct();
                    Question.numAnswer = nan;
                    Question.strAnswer = 'skipped';
                    
                    % get question properties
                    Question.Title =  Answers.(ID).title;
                    Question.Type = Type;
                    Question.Labels = '';
                    
                end
                
                %             case 'GroupQuestions'
                %
                %                Question = extractGroupQs(Answers.(ID));
                
                
            otherwise
                disp([ID, ' ', Type, 'didnt work'])
        end
        
        
        
        
        
        subQs = size(Question, 2);
        
        for Indx_sQ = 1:subQs
            
            allAnswers(newIndx).qID = ID;
            allAnswers(newIndx).Time = Time;
            
            allAnswers(newIndx).Question = Question(Indx_sQ).Title;
            allAnswers(newIndx).Type = Question(Indx_sQ).Type;
            allAnswers(newIndx).Labels = Question(Indx_sQ).Labels;
            
            allAnswers(newIndx).strAnswer = Question(Indx_sQ).strAnswer; % in case o extra text, or extra radio button
            allAnswers(newIndx).numAnswer = Question(Indx_sQ).numAnswer;
            allAnswers(newIndx).isOK =  Answers.(ID).isOk;
            
            newIndx = newIndx + 1;
        end
    end
end



