function setDedug(Log, varargin)
    if isempty(varargin)
        Log.options.isDebug = ~Log.options.isDebug;
    else
        Log.options.isDebug = logical(varargin{1});
    end
end