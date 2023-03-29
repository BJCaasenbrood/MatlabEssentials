%ISFLINT Check if a scalar or vector is a floating-point integer.
%
%   ISF = ISFLINT(M) returns true if the input scalar or vector M contains
%   only floating-point integers, and false otherwise. M must be a double
%   vector. A floating-point integer is defined as a number that is within
%   the range of the MATLAB function "flintmax", and has no fractional part.
%
%   Example:
%       % Check if a vector of values is a floating-point integer.
%       m = [1.0, 2.0, 3.0, 4.0];
%       isf = isflint(m);
%
%   See also FLINTMAX.

function isf = isflint(m)
    assert( isa( m, 'double' ) && isvector( m )     ...
        ,   'isflint:IllegalInput'                  ...
        ,   'The input should be a double vector'   )
    isf =   all( abs(   m ) <= flintmax ) ...
        &&  all( floor( m ) == m        ) ; 
end