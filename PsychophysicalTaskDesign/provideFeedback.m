function provideFeedback(window, subjectAnswer, trueAnswer, i)
    if subjectAnswer(i) == trueAnswer(i)
        message = 'Correct Answer';
        DrawFormattedText(window, message, 'center', 'center', [0, 256, 0]);
    else
        message = 'Wrong Answer';
        DrawFormattedText(window, message, 'center', 'center', [256, 0, 0]);
    end

    HideCursor;
    Screen('Flip', window);
end
