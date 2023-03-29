% CLRMAPPING - Map a colormap to a new size or style
%
%    CLRMAPPING maps a given colormap to a new size or style based on the 
%    input argument. The function can resample a colormap to a different 
%    number of colors, flip the colormap, or apply a special pattern.
%
% Syntax:
% ------
%    colmap = clrmapping(colmap, arg)
%
% Inputs:
% -------
%    colmap - A 2-D matrix of size N-by-3, where N is the number of colors 
%             in the colormap. Each row of the matrix represents an RGB 
%             color triple in the range of [0, 1]. The colormap can be a 
%             built-in MATLAB colormap or a user-defined colormap.
%
%    arg - A scalar numeric value that determines how to map the colormap.
%          The argument can take the following values:
%          - arg > 1: Resample the colormap to arg colors.
%          - arg < 0: Flip the colormap and resample to abs(arg) colors.
%          - arg = 0: Apply a special pattern to the colormap.
%
% Outputs:
% --------
%    colmap - A 2-D matrix of size M-by-3, where M is the number of colors 
%             in the mapped colormap. Each row of the matrix represents an 
%             RGB color triple in the range of [0, 1].
%
% Examples:
% ---------
%    Example 1: Resample a colormap to a new size
%
%       % Define a 5-by-3 matrix representing a custom colormap
%       mycolormap = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 1 1];
%
%       % Map the colormap to a new size of 10 colors
%       newcolormap = clrmapping(mycolormap, 10);
%
%    Example 2: Flip and resample a colormap
%
%       % Use the built-in 'cool' colormap
%       origcolormap = cool(8);
%
%       % Flip and resample the colormap to 5 colors
%       newcolormap = clrmapping(origcolormap, -5);
%
%    Example 3: Apply a mirror pattern to a colormap
%
%       % Use the built-in 'hot' colormap
%       origcolormap = hot(64);
%
%       % Apply a mirror pattern to the colormap
%       newcolormap = clrmapping(origcolormap, 0);
%

function colmap = clrmapping(colmap,arg)

if arg > 1
    x = linspace(0,1,length(colmap));
    xq = linspace(0,1,arg);
    colmap = interp1(x,colmap,xq);
elseif arg < 0
    if abs(arg) == 1, arg = 1e3; end
    x = linspace(0,1,length(colmap));
    xq = linspace(0,1,abs(arg));
    colmap = interp1(x,colmap,xq);
    colmap = flipud(colmap);
elseif arg == 0
    A = flipud(colmap(1:50,:));
    B = flipud(colmap(51:end,:));
    colmap = [A;flipud(A);flipud(B);B];
end

end
