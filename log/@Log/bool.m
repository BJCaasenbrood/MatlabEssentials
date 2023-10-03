function bool(Log, msg, varargin)
    
    if ~isempty(varargin)
        Boolean = varargin{1};
    else
        Boolean = true;
    end

    if Boolean
        tcprintf(Log.options.Color.True, msg);
        tcprintf(Log.options.Color.True, ' ✔ ');
    else 

        tcprintf(Log.options.Color.False, msg);
        tcprintf(Log.options.Color.False, ' ✗ ');
    end
    tcprintf('default','\n');
end
