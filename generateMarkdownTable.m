function generateMarkdownTable(functionFiles, outputFile)
% generateFunctionTable - Generates a Markdown table of function names and descriptions.
%
%   generateFunctionTable(functionFiles, outputFile) reads the first line of
%   each MATLAB function file in the cell array functionFiles, and produces a
%   Markdown table with the function name and description. The output is
%   written to the file specified by outputFile.
%
%   The function name and first line of each function file are processed
%   to meet the following requirements:
%
%   - The function name is wrapped in backticks to indicate code formatting.
%   - All-caps words and % characters are removed from the first line.

% Initialize the table with the header row.
tableData = {'Function Name', 'Description'; '---', '---'};

% Iterate over the input cell array.
for i = 1:numel(functionFiles)
    % Get the name of the current function file.
    [~, functionName, ~] = fileparts(functionFiles{i});
    
    % Read the first line of the file.
    fileID = fopen(functionFiles{i}, 'r');
    firstLine = fgetl(fileID);
    fclose(fileID);
    
    % Remove all-caps words and % characters from the first line.
    firstLine = regexprep(firstLine, '\<[A-Z\s%]+\>', '');
    
    % Wrap the function name in backticks for code formatting.
    functionName = sprintf('`%s`', functionName);
    
    % Add the function name and description to the table data.
    tableData(end+1,:) = {functionName, firstLine};
end

% Generate the Markdown table from the table data.
tableMarkdown = join(string(tableData), ' | ');

% Write the Markdown table to the output file.
fileID = fopen(outputFile, 'w');
fprintf(fileID, '%s\n', tableMarkdown);
fclose(fileID);
