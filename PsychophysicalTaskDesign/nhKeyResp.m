function key = nhKeyResp(KbIdx, kQ, kSpace)
    key = nan;
    while ~(key(1) == kSpace || key(1) == kQ)
        key(1) = nhKeyRespInner(KbIdx);
    end
end