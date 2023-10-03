classdef Log

    properties (Access = public)
        options
    end

methods  

% constructor 
function obj = Log(varargin) 
    obj.options = logoptions;

    % simple print
    if nargin == 1
        obj.info(varargin{1});
    elseif nargin == 2
        obj.(varargin{1})(varargin{2});
    end
end

end
end