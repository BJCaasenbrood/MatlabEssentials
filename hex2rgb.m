function rgb = hex2rgb(hex, range)
%HEX2RGB Convert hexadecimal color codes to RGB color values.
%
%   RGB = HEX2RGB(HEX) converts a character vector or cell array of
%   character vectors representing hexadecimal color codes to an N-by-3
%   matrix of RGB color values. The hexadecimal color codes may or may not
%   include the "#" symbol as a prefix.
%
%   RGB = HEX2RGB(HEX, RANGE) converts the hexadecimal color codes to RGB
%   values using either a range of 0 to 1 (RANGE = 1, default) or a range of
%   0 to 255 (RANGE = 256). The RANGE input must be a scalar integer.
%
%   Inputs:
%   -------
%   HEX - Character vector or cell array of character vectors representing
%         hexadecimal color codes.
%
%   RANGE (optional) - Scalar integer indicating the range of the output RGB
%         values. The default value is 1. Accepted values are 1 and 256.
%
%   Output:
%   -------
%   RGB - N-by-3 matrix of RGB color values, where N is the number of input
%         hexadecimal color codes. The RGB values are in the range of 0 to 1
%         or 0 to 255, depending on the value of RANGE.
%
%   Example:
%   --------
%   % Convert a single hexadecimal color code to an RGB value:
%   rgb = hex2rgb('7FFFD4')
%
%   % Convert multiple hexadecimal color codes to RGB values:
%   hex = {'FF0000', '00FF00', '0000FF'};
%   rgb = hex2rgb(hex)
%
%   See also RGB2HEX.

%   Chad A. Greene, April 2014
%   Modified by [Your Name], March 2023

% Input checks:
assert(nargin > 0 && nargin < 3, 'hex2rgb function must have one or two inputs.')

if nargin == 2
    assert(isscalar(range), 'Range must be a scalar, either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
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
elseif range == 256
    rgb = reshape(sscanf(hex.', '%2x'), 3, []).';
else
    error('Range must be either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end

end
