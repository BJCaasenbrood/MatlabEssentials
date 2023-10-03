function debug(Log, msg)
    
    if Log.options.isDebug 
    tcprintf(Log.options.Color.Debug, 'DEBU ');

    fileinfo(Log);

    tcprintf(Log.options.Color.TextHide, msg);
    tcprintf('','\n');
    end
end