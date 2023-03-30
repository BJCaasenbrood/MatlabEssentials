function fileList = findnoprefix(dirPath, prefix)
% Finds all files in a directory that do not start with a specific prefix
% Inputs:
%   - dirPath: path to directory to search for files (string)
%   - prefix: prefix to exclude from file names (string)
% Output:
%   - fileList: cell array of file names without the specified prefix

% Get list of all files in directory
fileList = dir(fullfile(dirPath, '*'));

% Filter out directories and files starting with specified prefix
isFile = ~[fileList.isdir];
hasPrefix = strncmp({fileList.name}, prefix, length(prefix));
fileList = {fileList(~isFile & ~hasPrefix).name};

end
