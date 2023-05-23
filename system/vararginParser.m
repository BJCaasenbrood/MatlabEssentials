function obj = vararginParser(obj,varargin)

    for ii = 1:2:length(varargin)
        if isprop(obj, varargin{ii})
            obj.(varargin{ii}) = varargin{ii + 1};
        elseif isprop(obj,'options')
            if isprop(obj.options, varargin{ii})
                obj.options.(varargin{ii}) = varargin{ii + 1};
            end
        elseif isprop(obj, 'solver')
            if isprop(obj.solver, varargin{ii})
                obj.solver.(varargin{ii}) = varargin{ii + 1};
            end
        elseif isprop(obj, 'params')
            if isfield(obj.params, varargin{ii})
                obj.params.(varargin{ii}) = varargin{ii + 1};
            end
        end
    end

end
