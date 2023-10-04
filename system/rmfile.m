function rmfile(varargin)
    log = Log;
    filename = varargin{1};
    path = pwd;

    if exist('.trash', 'dir') == 0
        mkdir .trash
    end

    if exist(filename, 'file') == 2

        log.warn(['File "', filename, '" is about to be move to .trash']);
        out = input('Continue? (Y/N)','s');
        if strcmpi(out,'y')
            movefile(filename,'.trash/');
        end
    else
        log.warn(['File "', filename, '" does not exist.']);
    end
end
