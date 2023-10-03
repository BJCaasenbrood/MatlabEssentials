function warn(Log, msg)

    tcprintf(Log.options.Color.Warn, 'WARN ');
    tcprintf(Log.options.Color.Warn, msg);
    tcprintf('','\n');

end