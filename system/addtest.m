function addtest(name)
% ADDTEST creates a new test file with a unique name

% count the number of existing test files in the directory
files = dir('*.m');
num_files = length(files);

% construct the new filename based on the number of existing files
filename = sprintf('Test%d_%s.m', num_files + 1, name);

% create the new test file and write some boilerplate code
fid = fopen(filename, 'w');
%fprintf(fid, 'function %s\n', filename(1:end-2));
fprintf(fid, '%% %s\n', datestr(now));
fprintf(fid, '%% Auto-generated test script\n\n');
fprintf(fid, '%% Initialize the test suite\n');
%fprintf(fid, 'initTestSuite;\n\n');
fprintf(fid, '%% Add test cases here\n\n');
%fprintf(fid, '%% Run the test suite\n');
%fprintf(fid, 'runtests(''Verbose'', true);\n');

% close the file handle
fclose(fid);

% display a message indicating the new filename
disp(['New test file created: ' filename]);
end

