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

            % create template with basic information
            oldQuestion.type = 'skipped';
            newQuestion = InitializeQ(oldQuestion);

            newQuestion.strAnswer = 'skipped';
        end
    case 'GroupQuestions'
        newQuestion = extractGroupQs(oldQuestion);
    case 'RepeatGroupQuestions'
        newQuestion = repeatGroupQuestions(oldQuestion);
    otherwise
        disp([oldQuestion.id, ' ', Type, 'didnt work'])
        newQuestion = [];
end