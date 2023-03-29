%ISPOS Check if a scalar is positive.
%
%   Y = ISPOS(X) returns true if the input scalar X is positive, and false
%   otherwise.
%
%   Example:
%       % Check if a scalar value is positive.
%       x = 5;
%       y = ispos(x);
%
%   See also ISNEG.

function y = ispos(x)

if x > 0, y = true;
else, y = false;
end
end

