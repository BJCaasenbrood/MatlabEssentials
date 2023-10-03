function info(Log, msg)
    
    tcprintf(Log.options.Color.Info, Log.options.Tag.Info);
    tcprintf(Log.options.Color.Info, ' ');
    tcprintf(Log.options.Color.TextInfo, msg);
    tcprintf('','\n');

end