%ANNIHIL Compute the annihilator of a set of vectors.
%
% Y = ANNIHIL(X) returns the annihilator of the set of column vectors X,
% which is the set of all row vectors Y such that Y*X = 0. Y is a matrix
% with as many rows as X has columns and an arbitrary number of columns.
%
% The annihilator of a set of vectors is used in linear algebra to describe
% the set of all linear functionals that vanish on the given vectors.
%
% Example:
%   X = [1 2 3; 4 5 6];
%   Y = annihil(X) returns the matrix Y = [-1 -2 -3], which satisfies Y*X = 0.
%
% See also NULL.

function Y = annihil(X)
Y  = null(X.').';
end

