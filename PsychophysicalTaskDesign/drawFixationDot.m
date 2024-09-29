function drawFixationDot(window, dotSizePix)
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    [xCenter, yCenter] = RectCenter(Screen('Rect', window));
    dotRect = [xCenter - dotSizePix, yCenter - dotSizePix, xCenter + dotSizePix, yCenter + dotSizePix];
    dotColor = [255, 255, 255]; % White color
    Screen('FillOval', window, dotColor, dotRect);
    Screen('Flip', window);
    WaitSecs(0.5);
end