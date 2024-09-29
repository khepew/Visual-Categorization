function [accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody] = updateAccuracyCounters(subjectAnswer, trueAnswer, i, group, accuracyCloseBody, accuracyFarBody, accuracyHead, accuracyMediumBody)
    if (subjectAnswer(i) == trueAnswer(i)) && (strcmp(group, 'Close'))
        accuracyCloseBody = accuracyCloseBody + 1;
    elseif (subjectAnswer(i) == trueAnswer(i)) && (strcmp(group, 'Far'))
        accuracyFarBody = accuracyFarBody + 1;
    elseif (subjectAnswer(i) == trueAnswer(i)) && (strcmp(group, 'Head'))
        accuracyHead = accuracyHead + 1;
    elseif (subjectAnswer(i) == trueAnswer(i)) && (strcmp(group, 'Medium'))
        accuracyMediumBody = accuracyMediumBody + 1;
    end
end