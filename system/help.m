function [out, docTopic] = help(varargin)
    cleanup.cache = matlab.internal.language.introspective.cache.enable; %#ok<STRNU> 

    nargout_ = 1;
    process = matlab.internal.help.helpProcess(nargout_, nargin, varargin);
    if isnumeric(process.inputTopic)
        process.inputTopic = inputname(process.inputTopic);
    end

    try %#ok<TRYNC>
        % no need to tell customers about internal errors
        % I KNOW NOW!

        try %#ok<TRYNC>
            process.executionContext = evalin('caller', 'matlab.internal.language.introspective.ExecutionContext.create');
        end

        process.getHelpText;
        % process.prepareHelpForDisplay;
    end

    
    if nargout > 0
        out = process.helpStr;
        if nargout > 1
            docTopic = process.docLinks.referencePage;
            if isempty(docTopic)
                docTopic = process.docLinks.productName;
            end
        end
    end

    str = process.helpStr;
    str = strrep(str,'%','%%');
    str = strrep(str,'%','%%');
    str = strrep(str,'%','%%');

    str = strrep(str,'\','\\');
    str = strrep(str,'\','\\');

    
    tcprintf('darkGray',str);
    tcprintf('black','');
end
