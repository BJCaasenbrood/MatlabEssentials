function err(Log, msg, varargin)
    
    % tcprintf('text', ' ');
    tcprintf(Log.options.Color.Error, 'ERRO');
    tcprintf('black',' ');

    S = dbstack(1);
    files = {S.file};
    line  = num2str(S.line);
    tcprintf(Log.options.Color.TextHide, ['<',files{1},':',line,'> ']);

    tcprintf(Log.options.Color.TextInfo, msg);
    tcprintf('','\n');
end