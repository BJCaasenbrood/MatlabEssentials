%CMAPPING Interpolate, decimate, or flip a colormap.
%
% COLMAP = CMAPPING(COLMAP, ARG) returns an interpolated colormap or a
% flipped colormap, depending on the sign of ARG. COLMAP is an M-by-3 matrix
% of RGB values, where M is the number of colors in the colormap. If ARG is
% greater than 1, CMAPPING interpolates the colormap to have ARG colors. If
% ARG is less than 0, CMAPPING flips the colormap and interpolates it to
% have ABS(ARG) colors. If ARG is equal to 0, CMAPPING flips the colormap
% and repeats the first half of the original colormap twice, then repeats
% the second half of the original colormap twice. The resulting colormap
% has 200 colors.
%
% Example:
%   COLORMAP = hsv(256);
%   NEWCOLORMAP = cmapping(COLORMAP, 128) returns a new colormap with 128
%   colors that is interpolated from the original colormap.
%
% See also COLORMAP, INTERP1.

function colmap = cmapping(colmap,arg)

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
