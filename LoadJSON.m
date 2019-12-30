clc
clear
close all

REBQparameters


Filename.Data = [Folders.Data, 'pilot1_Dreams.json'];

Struct = jsondecode(fileread(Filename.Data));

Answers = Struct.answers;

Questions = fieldnames(Answers);

for Indx_Q = 1:numel(Questions)
    Idx = Questions{Indx_Q};
    try
        Title = Answers.(Idx).title.props.children;
    catch
        Title = Answers.(Idx).id;
    end
    
    disp(Title)
    if Answers.(Idx).wasShown
        Type = Answers.(Idx).type;
        disp(Type)
        switch Type
            case 'Slider'
                Labels= Answers.(Idx).questionProps.labels;
                disp([(Labels'), Answers.(Idx).data.answer])
            case 'SliderGroup'
                Slider_tot = size(Answers.(Idx).questionProps, 1);
                for Indx_S = 1:Slider_tot
                    
                    
                    try
                        if isfield(Answers.(Idx).questionProps{Indx_S}, 'question') % TODO, check that this is what its called
                            Question= [Answers.(Idx).questionProps{Indx_S}.question, ' '];
                        else
                            Question = '';
                        end
                        if isfield(Answers.(Idx).questionProps{Indx_S}, 'labels') % TODO, check that this is what its called
                            Labels= Answers.(Idx).questionProps{Indx_S}.labels;
                            
                        else
                            Labels = '';
                        end
                    catch %% because the thing gets saved differently
                        if isfield(Answers.(Idx).questionProps, 'question') % TODO, check that this is what its called
                            Question= [Answers.(Idx).questionProps(Indx_S).question, ' '];
                        else
                            Question = '';
                        end
                        if isfield(Answers.(Idx).questionProps, 'labels') % TODO, check that this is what its called
                            Labels= Answers.(Idx).questionProps(Indx_S).labels;
                            
                        else
                            Labels = '';
                        end
                    end
                    disp([Question, Labels',  num2str(Answers.(Idx).data.answers(Indx_S))])
                end
            case 'TypeInput'
                
                if isfield(Answers.(Idx).data, 'extraRadio') % TODO, check that this is what its called
                    Choice = Answers.(Idx).data.extraRadio + 1;
                    Text = Answers.(Idx).questionProps.extraRadio(Choice);
                    disp("extra")
                else
                    Text = [Answers.(Idx).data.text];
                end
                
                disp(Text)
            case 'Radio'
                
                Options = Answers.(Idx).questionProps.options;
                Choice = Answers.(Idx).data.answer + 1;
                if isfield(Answers.(Idx).data, 'extraText')
                    extraText = Answers.(Idx).data.extraText;
                else
                    extraText = '';
                end
                try
                disp([Options{Choice}.text, extraText])
                catch
                      disp([Options(Choice).text, extraText])
                end
            case 'YesNo'
                
                disp(Answers.(Idx).data.answer)
            case 'MultipleChoice'
                Choices = find(Answers.(Idx).data.answers);
                for Indx_C = 1:numel(Choices)
                    disp([Answers.(Idx).questionProps.options{Indx_C}.text, Answers.(Idx).data.extraTexts{Indx_C}])
                end
            case 'RepeatGroupQuestions'
                % TODO when I have this as a function and can do recursion
        end
    else
        disp("not shown")
    end
end