%WHEREIS Locate a file or function on the MATLAB search path.
%
% STR = WHEREIS(FILENAME) returns a character array containing the full
% path to the file or function specified by FILENAME, as well as any other
% files or functions with the same name that are found on the MATLAB search
% path. If FILENAME is not found on the search path, STR is an empty array.
%
% Example:
%   whereis('myfunction') returns a character array containing the full
%   path to the function 'myfunction' and any other functions with the same
%   name that are found on the MATLAB search path.
%
% See also WHICH.

function str = whereis(varargin)
assert(isa(varargin{1},'char'), 'Input must be a charactar array.');
[str,shadow] = which(varargin{1},'-all');
if numel(str) > 1
    for ii = 1:numel(str)
        if isempty(shadow{ii})
            fprintf('[x] ');
        else
            fprintf('[ ] ');
        end

        fprintf([str{ii}, '\n']);
    end
else
    fprintf(['[x]', str{1}, '\n']);
end
end