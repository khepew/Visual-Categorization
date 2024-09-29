function key = nhKeyRespInner(KbIdx)
    while KbCheck(KbIdx)
    end % Wait until all keys are released.

    keyIsDown = false;

    while ~keyIsDown
        [keyIsDown, ~, keyCode] = KbCheck(KbIdx);

        if keyIsDown
            key = find(keyCode);
            while KbCheck(-1)
            end
        end
    end
end