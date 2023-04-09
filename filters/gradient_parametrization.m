function [param_curve, t] = gradient_parametrization(curve, N, gamma)
% Inputs:
%   curve - an n x 2 matrix representing the (x,y) coordinates of the
%           vertices of a closed curve in 2D
%   N - an integer representing the desired number of samples in the
%       parameterized curve
%   gamma - a scalar representing the weighting factor for the gradient
%           of the curve
%
% Outputs:
%   param_curve - an N x 2 matrix representing the (x,y) coordinates of
%                 the parameterized curve
%   t - an N x 1 vector representing the parameter values of the curve
%       (ranging from 0 to 1)

% Check that the input curve is closed (i.e. first and last vertices are the same)
if ~isequal(curve(1,:), curve(end,:))
    error('Input curve must be closed');
end

% Compute the gradient of the curve
gradient = abs(diff(curve([end,1:end,1],:),1,1));

% Compute the cumulative sum of the gradient
cumulative_gradient = cumsum(gradient);

% Compute the normalized parameter values
t = linspace(0, 1, N)';
t_index = floor(t*(size(curve,1)-1))+1;

% Compute the weighting factor for each point based on the gradient
weights = gamma*cumulative_gradient(t_index)/cumulative_gradient(end) + (1-gamma);

% Interpolate the curve at the parameter values with weighting
param_curve = interp1(1:size(curve,1), curve, t_index, 'linear', 'extrap');
param_curve = param_curve.*repmat(weights,1,2);

end
