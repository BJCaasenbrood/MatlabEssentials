function fileNames = findextension(path, extension)
% Find all files with a specific extension in a folder
%
% Inputs:
%   - folderPath: a string specifying the path to the folder
%   - extension: a string specifying the file extension (e.g. '.txt')
%
% Output:
%   - fileNames: a cell array containing the names of all files with the
%     specified extension in the folder

% Get a list of all files in the folder
files = dir(fullfile((path, '*'));

% Initialize a cell array to store the file names
fileNames = {};

% Loop through each file in the folder
for i = 1:length(files)
    % Check if the file has the specified extension
    [~, ~, fileExt] = fileparts(files(i).name);
    if strcmp(fileExt, extension)
        % Add the file name to the list
        fileNames = [fileNames; files(i).name];
    end
end
