function [QuestionnaireName, DateTime] = extractFilename(Q)
% get the time; this is convoluted and there may be a better way
dateExpression =  '(\d+)-(\d+)-(\d+)T(\d+)_(\d+)_(\d+).(\d+)-'; % this is the format of the date in the file name;
[D1, D2] = regexp(Q, dateExpression); % this gets the indixes of the above string

if length(D2) < 1
    dateExpression =   '(\d+)-(\d+)-(\d+)T(\d+)_(\d+)_(\d+).(\d+)\w-';
    [D1, D2] = regexp(Q, dateExpression); % this gets the indixes of the above string
    DateString = extractBefore(Q(D1:D2), '.');
    DateNum = datenum(DateString,'yyyy-mm-ddTHH_MM_SS'); % this converts the time to an absolute number
    DateTime = datetime(DateNum, 'convertFrom', 'datenum', 'TimeZone', 'UTC'); % this actually as a date
    DateTime.TimeZone = 'Europe/Zurich';
else
    DateString = extractBefore(Q(D1:D2), '.'); % this extracts the time before the subsecond levels
    DateNum = datenum(DateString,'yyyy-mm-ddTHH_MM_SS'); % this converts the time to an absolute number
    DateTime = datetime(DateNum, 'convertFrom', 'datenum', 'TimeZone', 'UTC'); % this actually as a date
    DateTime.TimeZone = 'Europe/Zurich';
end


% get the questionnaire name
QuestionnaireName = Q(D2+1:end);
QuestionnaireName = deblank(strrep(QuestionnaireName, '-', '_'));