function bool(Log, msg, varargin)
    
    msg_bool   = [];
    windowSize = get(0, 'CommandWindowSize');
    defaultbar = round(windowSize(1) * 0.475);

    if ~isempty(varargin)
        Boolean = varargin{1};
        if numel(varargin) == 2
            assert(isa(varargin{2},'cell'), ...
                'Conditional str output must be a cell {msg_true, msg_false}');

            if Boolean
                msg_bool = varargin{2}{1};
            else
                msg_bool = varargin{2}{2};
            end

            defaultbar = defaultbar - numel(msg_bool) - numel(msg)  - 1;
        end
    else
        Boolean = true;
    end

    if Boolean
        tcprintf(Log.options.Color.TextInfo, msg);

        if ~isempty(msg_bool)
            tcprintf(Log.options.Color.TextHide, [' ', repmat('.',1,defaultbar) , ' ']);
            tcprintf(Log.options.Color.True, msg_bool);
        end

        tcprintf(Log.options.Color.True, ' ✔ ');
    else 

        tcprintf(Log.options.Color.TextInfo, msg);

        if ~isempty(msg_bool)
            tcprintf(Log.options.Color.TextHide, [' ', repmat('.',1,defaultbar), ' ']);
            tcprintf(Log.options.Color.False, msg_bool);
        end

        tcprintf(Log.options.Color.False, ' ✗ ');
    end

    tcprintf('default','\n');
end
