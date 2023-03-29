%CLAMP Limit the values of an array between lower and upper bounds.
%
% Y = CLAMP(X, LOW, UPP) returns an array Y with the same size and shape as
% X, but with each element of X limited between the lower bound LOW and the
% upper bound UPP. Any element of X less than LOW is replaced by LOW, and
% any element greater than UPP is replaced by UPP.
%
% If LOW and UPP are not provided together as arguments, they must be
% provided in a 2-element vector as the second argument, [LOW, UPP].
%
% Examples:
%   clamp([1 2 3], 2, 4) returns [2 2 3].
%   clamp([1 2 3], [2 4]) returns [2 2 3].
%   clamp([-1 2 5 7], 0, 6) returns [0 2 5 6].
%
% See also MIN, MAX.

function y = clamp(x,low,upp)

if nargin < 2
	assert(numel(low) == 2, 'Second argument must be [low,upp], or clamp(x,low,upp)');
	upp = low(2);
	low = low(1);
end

y=min(max(x,low),upp);

end
