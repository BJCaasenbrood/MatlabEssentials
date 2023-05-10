function f = benchmark(varargin)
    str = strcat(varargin{:});
    fncStr = strcat("@(x) ", str);
    %disp(fncStr);
    f = str2func(char(fncStr));
    %eval(fncStr);
    f([]);
end