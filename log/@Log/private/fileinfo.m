function str = fileinfo(Log)

    S = dbstack(2);
    files = {S.file};
    lines = {S.line};
    names = {S.name};

    % str = [];
    % if numel(names) > 2
    %     for ii = 1:2
    %         str = [str, names{ii},'/'];
    %     end
    %     str = [str(1:end-1),'.m/'];
    % else
    %     str = [names{1},'.m/'];
    % end

    if ~isempty(files)
        str = ['<',files{1},':',num2str(lines{1}),'> '];
        tcprintf(Log.options.Color.TextHide, str);
    end

end