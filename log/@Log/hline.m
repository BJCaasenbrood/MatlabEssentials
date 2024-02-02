function hline(Log,varargin)

    windowSize = get(0, 'CommandWindowSize');
    arrayLen = round(windowSize(1) * 0.5);

    if ~isempty(varargin)
        msg = [varargin{1},' '];
    else
        msg = '';
    end

    lineStr = repmat('━', 1, arrayLen + 1 - numel(msg));

    tcprintf(Log.options.Color.TextInfo, msg);
    tcprintf(Log.options.Color.TextInfo, lineStr);
    tcprintf('','\n');
    
end