%HEX2RGB Convert hexadecimal color codes to RGB values.
%
%   RGB = HEX2RGB(HEX) converts a hexadecimal color code represented by HEX
%   into its corresponding RGB values. HEX can be a string or a cell array of
%   strings, where each string represents a color code. If HEX is a cell
%   array, RGB will be a matrix with each row representing the RGB values
%   for a color code.
%
%   RGB = HEX2RGB(HEX, RANGE) specifies the range of the RGB values returned
%   by the function. If RANGE is "1", the RGB values will be scaled to the
%   range [0, 1]. If RANGE is "255", the RGB values will be scaled to the
%   range [0, 255]. If RANGE is not specified, the default value is "1".
%
%   Example:
%       % Convert a single hexadecimal color code to RGB.
%       hex = '#FF5733';
%       rgb = hex2rgb(hex);
%
%       % Convert multiple hexadecimal color codes to RGB.
%       hex = {'#FF5733', '#C70039', '#900C3F'};
%       rgb = hex2rgb(hex);
%
%       % Convert a hexadecimal color code to RGB with values in the range
%       % [0, 255].
%       hex = '#FF5733';
%       rgb = hex2rgb(hex, 255);
%
%   See also RGB2HEX.


function rgb = hex2rgb(hex, range)
assert(nargin > 0 && nargin < 3, 'hex2rgb function must have one or two inputs.')

if nargin == 2
    assert(isscalar(range), 'Range must be a scalar, either "1" to scale from 0 to 1 or "255" to scale from 0 to 255.')
end

% Tweak inputs if necessary:
if iscell(hex)
    assert(isvector(hex), 'Unexpected dimensions of input hex values.')

    if isrow(hex)
        hex = hex';
    end

    % If input is cell, convert to matrix:
    hex = cell2mat(hex);
end

if strcmpi(hex(1, 1), '#')
    hex(:, 1) = [];
end

if nargin == 1
    range = 1;
end

% Convert from hex to RGB:
if range == 1
    rgb = reshape(sscanf(hex.', '%2x'), 3, []).'/255;
elseif range == 255
    rgb = reshape(sscanf(hex.', '%2x'), 3, []).';
else
    error('Range must be either "1" to scale from 0 to 1 or "255" to scale from 0 to 255.')
end

end
