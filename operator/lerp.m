% LERP Linearly interpolates between two values.
%
%   y = lerp(a, b, t) returns the linear interpolation between values a and b
%   based on the parameter t. The value of t should be between 0 and 1,
%   inclusive. If t is greater than 1, it will be clamped to 1. If t is less
%   than 0, it will be clamped to 0.
%
%
% Example:
%   y = lerp(2, 5, 0.5);
%   % y = 3.5

function y = lerp(a, b, t)

if t > 1
    t = 1;
elseif t < 0
    t = 0;
end

y = a + t * (b - a);

end
