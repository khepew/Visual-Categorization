function thankYouMessage(window)
    message = 'Thank You :) Press Any Key to Close the Window & See Your Results.';
    DrawFormattedText(window, message, 'center', 'center', [256, 256, 256]);
    HideCursor;
    Screen('Flip', window);
end