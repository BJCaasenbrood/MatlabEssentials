function isdocumented(varargin)

    if nargin < 1
        folderPath = pwd;
    else
        folderPath = varargin{1};
    end

    % Get a list of all files in the folder
    log = Log;
    files = dir(fullfile(folderPath, '*.m'));
    
    % Initialize a flag to track if any undocumented files are found
    isUndocumentedFound = false;
    
    % Loop through each file
    for i = 1:numel(files)
        filePath = fullfile(folderPath, files(i).name);
        
        % Read the contents of the file
        fileContents = fileread(filePath);
        
        % Check if the file contains a documentation block
        Name = files(i).name(1:end-2); 

        if ~contains(fileContents, ['% ', upper(Name)]) && ...
            ~contains(fileContents, ['%', upper(Name)])
            
            str = sprintf('❌ Undocumented file: %s', files(i).name);
            log.warn(str);
            isUndocumentedFound = true;
        else
            str = sprintf('✅ Documented file: %s', files(i).name);
            log.info(str);
        end
    end
    
    % Display a message if all files are documented
    if ~isUndocumentedFound
        disp('All files are documented. 👏👏');
    end
end
