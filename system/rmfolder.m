
function rmfolder(varargin)

if isempty(varargin)
    rmpath(genpath(cd));
else
    rmpath(genpath(varargin{1}));
end
end

