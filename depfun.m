%DEPFUN List dependencies required by a function.
%
%   VARARGOUT = DEPFUN(FILE) lists the files required by the function
%   specified by FILE, including any dependent functions and toolboxes. FILE
%   can be the full path to a file, or the name of a function on the MATLAB
%   search path.
%
%   VARARGOUT is a cell array of character vectors. The first element is a
%   description of the main file, followed by any dependent files.
%
%   Example:
%       % List the dependencies required by the "fft" function.
%       depfun('fft')
%
%   If called with no output arguments, DEPFUN will print the list of
%   dependencies to the command window.
%
%   See also MATLAB.CODETOOLS.REQUIREDFILESANDPRODUCTS.


function varargout = depfun(file)
assert(isa(file,'char'),'File name must be a character array.')
varargout{1} = matlab.codetools.requiredFilesAndProducts(file);

if nargout < 1
    for ii = 1:numel(varargout{1}) - 1
        str = varargout{1}{ii};
        fprintf([str, '\n']);
    end
    if (numel(varargout{1}) - 1) < 1
        fprintf('Function has no dependencies.\n');
    end
end