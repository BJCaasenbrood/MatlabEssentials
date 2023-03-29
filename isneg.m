%ISNEG Check if a scalar is negative.
%
%   Y = ISNEG(X) returns true if the input scalar X is negative, and false
%   otherwise.
%
%   Example:
%       % Check if a scalar value is negative.
%       x = -5;
%       y = isneg(x);
%
%   See also ISPOS.

function y = isneg(x)
if x < 0, y = true;
else, y = false;
end
end

