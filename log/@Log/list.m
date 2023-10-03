function list(Log, msg, list)
    
    N = numel(list);
    C1 = Log.options.Symbol.BulletStart;
    C2 = Log.options.Symbol.BulletMid;
    C3 = Log.options.Symbol.BulletEnd;

    if ~isempty(msg) || ~strcmp(msg,'')
        tcprintf(Log.options.Color.Info, 'INFO ');
        tcprintf(Log.options.Color.TextInfo, msg);
        tcprintf('','\n');
    end

    for ii = 1:N
        if ii == 1 && N > 1
            tcprintf(Log.options.Color.TextInfo, [' ',C1, ' ']);
        elseif ii == N
            tcprintf(Log.options.Color.TextInfo, [' ',C3, ' ']);
        else
            tcprintf(Log.options.Color.TextInfo, [' ',C2, ' ']);
        end
        tcprintf(Log.options.Color.TextInfo, list{ii});
        tcprintf('','\n');
    end

end