function obj = vararginParser(obj,varargin)

    for ii = 1:2:length(varargin)
        if isprop(obj, varargin{ii})
            obj.(varargin{ii}) = varargin{ii + 1};
        else
            obj.options.(varargin{ii}) = varargin{ii + 1};
        end
    end

end
