function extension = getextension(fullPath)
    [~, ~, extension] = fileparts(fullPath);
    extension = strcat(".", extension);
end