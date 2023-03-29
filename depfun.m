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