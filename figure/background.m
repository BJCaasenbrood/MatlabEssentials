%BACKGROUND Set the background color or image of the current figure.
%
% BACKGROUND(X) sets the background of the current figure to the color
% specified by X, which can be a 3-element vector of RGB values, a string
% containing the name of a color ('red', 'blue', etc.), or a hexadecimal
% RGB triplet (e.g., '#FF0000' for red).
%
% If X is not provided or is an empty matrix, the default color 'w'
% (white) is used.
%
% BACKGROUND(IMG) sets the background of the current figure to the image
% specified by IMG, which should be a numeric array or a filename string
% containing the path to an image file. If IMG is a filename, it can be
% in any format that MATLAB supports.
%
% Class support for input X and IMG:
%   - X can be a double or a char array.
%   - IMG can be any numeric array or char array containing the filename
%     of an image.
%
% Examples:
%   background('blue') sets the background of the current figure to blue.
%   background([0.2 0.4 0.6]) sets the background of the current figure to a
%     color with RGB values [0.2, 0.4, 0.6].
%   background('#FF0000') sets the background of the current figure to red.
%   background('') sets the background of the current figure to white.
%   background(rand(100,100)) sets the background of the current figure to a
%     random image.
%   background('myimage.png') sets the background of the current figure to
%     the image stored in the file 'myimage.png'.
%
% See also SET, GCF, IMAGESC.

function background(x)

if nargin < 1
    x = 'w';
end

if (isa(x,'double') && size(x(:),1) == 3) || (isa(x,'char'))
    fig = gcf;
    set(fig,'color', x);
    fig.InvertHardcopy = 'off';
else
    ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
    imagesc(x);
    set(ah,'handlevisibility','off','visible','off');
    uistack(ah,'bottom');
end

end


