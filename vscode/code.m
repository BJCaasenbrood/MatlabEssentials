function code(file, line)
    if nargin < 2
        addline = '';
    else
        addline = [':', num2str(line),':00'];
    end
    
    filepath = whereis(file);
    command = ['code --goto "', filepath, addline,'"'];
    [status, cmdout] = system(command);
end
