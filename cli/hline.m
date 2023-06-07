function hline(lineChar,varargin)

if nargin < 1
    lineChar = '=';
end

cmdWidth = get(0,'CommandWindowSize');
Line = repmat(lineChar,[1,cmdWidth(1) - 2]);

str = [Line,'\n'];
fprintf(str);

end

