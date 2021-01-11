function [Answers, Summary] = LoadScreening(AllAnswers, Participant, OverviewParticipants)



AllParticipants = {OverviewParticipants.Name};
ParticipantID = strcmp(AllParticipants, Participant);

Answers = table();
Summary = struct();
Summary.Participant = Participant;

AllAnswersP = AllAnswers(strcmp(AllAnswers.Participant, Participant), :);
PAnswered = unique(AllAnswersP.Questionnaire);

%%% if exists sensitive...
if ismember( 'Screening_Sensitive', PAnswered)
   [Answers, Summary] = isOK(AllAnswersP, Answers, Summary, 'Screening_Sensitive');
    Summary.SensitiveEligible = OverviewParticipants(ParticipantID).Screening_Sensitive_Eligible;
end

%%% PSQI
if ismember( 'Screening_PSQI', PAnswered)
   [Answers, Summary] = isOK(AllAnswersP, Answers, Summary, 'Screening_PSQI');
   Summary.PSQIScore = OverviewParticipants(ParticipantID).Screening_PSQI_Score;
   Summary.PSQIEligible = OverviewParticipants(ParticipantID).Screening_PSQI_Eligible;
end

%%% MCTQ
if ismember( 'Screening_MCTQ', PAnswered)
   [Answers, Summary] = isOK(AllAnswersP, Answers, Summary, 'Screening_MCTQ');
   Summary.MCTQScore = OverviewParticipants(ParticipantID).Screening_MCTQ_Score;
   Summary.MCTQEligible = OverviewParticipants(ParticipantID).Screening_MCTQ_Eligible;
end

%%% Wake
if ismember( 'Screening_Wake', PAnswered)
   [Answers, Summary] = isOK(AllAnswersP, Answers, Summary, 'Screening_Wake');
    Summary.WakeEligible = OverviewParticipants(ParticipantID).Screening_Wake_Eligible;
end


%%% Sleep
if ismember( 'Screening_Sleep', PAnswered)
   [Answers, Summary] = isOK(AllAnswersP, Answers, Summary, 'Screening_Sleep');
    Summary.SleepEligible = OverviewParticipants(ParticipantID).Screening_Sleep_Eligible;
end

end

function [Answers, Summary] = isOK(AllAnswersP, Answers, Summary, Questionnaire)

QShort = extractAfter(Questionnaire, 'Screening_');


 % get subset of answers
    SensitiveAnswersP = AllAnswersP(strcmp(AllAnswersP.Questionnaire, Questionnaire), :);
    SensitiveFailed = SensitiveAnswersP(SensitiveAnswersP.isOK == 0, :);
    
    % get counts of answers
    Summary.([QShort, 'Failed']) = size(SensitiveFailed, 1);% number of failed questions
    Summary.([QShort, 'Tot']) = size(SensitiveAnswersP, 1);
    

    if  Summary.([QShort, 'Failed']) > 0
    Summary.([QShort, 'Qs']) =  [SensitiveFailed.Question, SensitiveFailed.strAnswer];% list of failed questions & answers
    Answers = [Answers; SensitiveAnswersP];
    end
    
    Summary.([QShort, 'Time']) = max(SensitiveAnswersP.qTime) - min(SensitiveAnswersP.qTime);

end


% TODO:
% - get table of all screening answers
% - display all answers that failed
% - make a summary

