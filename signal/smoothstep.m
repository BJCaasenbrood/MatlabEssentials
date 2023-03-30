%SMOOTHSTEP Evaluate the smoothstep function for a given input value.
%
% Y = SMOOTHSTEP(X) returns the value of the smoothstep function for each
% element of X, where Y is the same size as X. The smoothstep function is
% defined as:
%
%   smoothstep(x) = 0                  if x <= 0
%                   3x^2 - 2x^3        if 0 < x < 1
%                   1                  if x >= 1
%
% The smoothstep function is commonly used in computer graphics to create
% smooth transitions between two values.
%
% Example:
%   smoothstep([0 0.5 1]) returns [0 0.8750 1].
%
% See also STEP.

function y = smoothstep(x)
I1 = (x<=0);
I2 = (x>0 & x<=1);
I3 = ~I1 & ~I2;
y = x;
y(I1) = 0;
y(I2) = 3*x(I2).^2 -2*x(I2).^3;
y(I3) = 1;
end