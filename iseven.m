%ISEVEN Check if an integer is even.
%
%   BOOL = ISEVEN(A) returns true if the input integer A is even, and false
%   otherwise. A can be a scalar or an array of integers.
%
%   Example:
%       % Check if a scalar integer value is even.
%       a = 4;
%       bool = iseven(a);
%
%   See also ISODD.

function bool = iseven(a)
bool = ~logical(rem(a,2));
end

