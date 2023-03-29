%ISODD Check if an integer is odd.
%
%   BOOL = ISODD(A) returns true if the input integer A is odd, and false
%   otherwise. A can be a scalar or an array of integers.
%
%   Example:
%       % Check if a scalar integer value is odd.
%       a = 5;
%       bool = isodd(a);
%
%   See also ISEVEN.

function bool = isodd(a)
bool = logical(rem(a,2));
end

