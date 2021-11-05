function newQuestion = Switchboard(oldQuestion, Type)
% function for choosing the appropriate question type

switch Type
    case 'Slider'
        newQuestion = extractSlider(oldQuestion);
    case 'SliderGroup'
        newQuestion = extractSliderGroup(oldQuestion);
    case 'MultipleChoice'
        newQuestion = extractMultipleChoice(oldQuestion);
    case 'Radio'
        newQuestion = extractRadio(oldQuestion);
    case 'RadioTable'
        newQuestion = extractRadioTable(oldQuestion);
    case 'YesNo'
        newQuestion = extractYesNo(oldQuestion);
    case 'YesNoGroup'
        newQuestion = extractYesNoGroup(oldQuestion);
    case 'TypeInput'
        newQuestion = extractInput(oldQuestion);
    case 'TypeInputGroup'
        newQuestion = extractInputGroup(oldQuestion);
    case 'Range'
        newQuestion = extractRange(oldQuestion);
    case 'ImageCoordinates'
        newQuestion = extractCoordinates(oldQuestion);
    case 'RankList'
        newQuestion = extractRank(oldQuestion);
    case ''
        if isfield( oldQuestion.data, 'answer')
            newQuestion = struct();
            newQuestion.numAnswer = nan;
            newQuestion.strAnswer = 'skipped';
            
            % get question properties
            newQuestion.Title =  oldQuestion.title;
            newQuestion.Type = Type;
            newQuestion.Labels = '';
        end
    case 'GroupQuestions'
        newQuestion = extractGroupQs(oldQuestion);
    otherwise
        disp([ID, ' ', Type, 'didnt work'])
        newQuestion = [];
end