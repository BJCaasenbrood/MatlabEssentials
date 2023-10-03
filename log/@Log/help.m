function help(Log, msg)
    
    tcprintf(Log.options.Color.Warn, 'HELP ');
    tcprintf([Log.options.Color.Warn, ' underline'], msg);
    tcprintf('','\n');

end