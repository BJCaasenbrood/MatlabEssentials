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

function B = annihilator(A, varargin)
    % Set the default annihilator type to 'left'
    annihilator_type = 'left';

    % Check if an optional input argument is provided
    if ~isempty(varargin)
        annihilator_type = varargin{1};
    end

    % Validate the input argument
    if ~strcmp(annihilator_type, 'left') && ~strcmp(annihilator_type, 'right')
        error('Invalid input argument. Use either ''left'' or ''right''.');
    end

    % Compute the annihilator matrix
    if strcmp(annihilator_type, 'left')
        nullSpace = null(A', 'r');
        B = nullSpace.';
    else
        B = null(A, 'r');
    end

    % Check if the product of B and A or A and B is close to the zero matrix
    if strcmp(annihilator_type, 'left') && norm(B * A) > 1e-6
        error('Failed to find a left annihilator matrix B. Try running the function again.');
    elseif strcmp(annihilator_type, 'right') && norm(A * B) > 1e-6
        error('Failed to find a right annihilator matrix B. Try running the function again.');
    end
end
