function setHide(Log, varargin)
    if isempty(varargin)
        Log.options.isHide = ~Log.options.isHide;
    else
        Log.options.isHide = logical(varargin{1});
    end

    if Log.options.isHide
        % Log.debug('text-hide is on');
        tcprintf(Log.options.Color.TextHide,'');
    else
        % Log.debug('text-hiclcde is off');
        tcprintf(Log.options.Color.TextInfo,'');
    end
end