% ADD2PATH Add specified directory or current directory to the search path.
%   add2path() adds the current directory and all its subdirectories to the
%   search path.
%
%   add2path(DIR) adds the specified directory, DIR, and all its
%   subdirectories to the search path.
%
%   Usage:
%     add2path;
%     add2path('path/to/directory');
%
%   Input:
%     DIR - (optional) A string specifying the directory to add to the search
%           path. If omitted, the current directory will be added.
%
%   Example:
%     add2path; % Adds the current directory and its subdirectories to the search path
%     add2path('path/to/my/functions'); % Adds the specified directory and its subdirectories to the search path
%
%   See also: rmpath, genpath, cd

function add2path(varargin)

if isempty(varargin)
    addpath(genpath(cd));
else
     addpath(genpath(varargin{1}));
end
end

