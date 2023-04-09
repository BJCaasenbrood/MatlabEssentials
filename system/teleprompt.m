function teleprompt(s)
    %TELEPROMPT prints to the command window, over-writing the last message
    %
    %       TELEPROMPT(S)
    %       TELEPROMPT()      % Terminate
    %
    %       Input S is a string.
    
    persistent lastMsg;
    
    if isempty(lastMsg)
        lastMsg = '';
    end
    
    if nargin == 0
        lastMsg = [];
        fprintf('\n');
        return
    end
    
    fprintf(repmat('\b', 1, numel(sprintf(lastMsg))));
    fprintf(s);
    
    lastMsg = s;
end