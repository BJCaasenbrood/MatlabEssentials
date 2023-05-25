% CODE Opens VSCode editor to a specific file and line number.
%
%   CODE FILE opens Visual Studio Code to the specified FILE.
%
%   CODE FILE LINE opens Visual Studio Code to the specified FILE at LINE
%   number specified by the user (default = 0).
%
%   Example:
%       code myFile will open 'myFile.m' in Visual Studio Code and
%       place the cursor at line number 10.
%
%   Note:
%       This function requires that the 'code' command is available in the
%       system path. If you are using a different editor or IDE, you may need
%       to modify this function to use the appropriate command.
%
% See also WHEREIS.

function code(name, line)

    % specify your editors symbolic path here
    editorpath = 'code';
    assert(nargin>0, 'CODE requires atleast a file name');

    if nargin < 2
        addline = '';
    else
        addline = [':', num2str(line),':00'];
    end
    
    filepath = which(name);
    command = [editorpath,' --goto "', filepath, addline,'"'];
    [status, cmdout] = system(command);
end
