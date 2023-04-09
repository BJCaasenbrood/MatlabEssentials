function smoothed_curve = smooth_closed_curve(curve, window_size, sigma)
% Inputs:
%   curve - an n x 2 matrix representing the (x,y) coordinates of the
%           vertices of a closed curve in 2D
%   window_size - an integer representing the number of neighboring vertices
%                 to include in the moving average window
%   sigma - a scalar representing the standard deviation of the Gaussian
%           weighting function
%
% Output:
%   smoothed_curve - an n x 2 matrix representing the (x,y) coordinates of
%                    the smoothed curve

% Check that the input curve is closed (i.e. first and last vertices are the same)
if ~isequal(curve(1,:), curve(end,:))
    error('Input curve must be closed');
end

% Create a Gaussian weighting function
gaussian = exp(-(linspace(-window_size/2, window_size/2, window_size).^2)/(2*sigma^2));
gaussian = gaussian/sum(gaussian);

% Pad the curve at the beginning and end to enable averaging over the boundary
padded_curve = [curve(end-window_size+1:end,:); curve; curve(1:window_size,:)];

% Compute the weighted moving average of the x and y coordinates separately
smoothed_x = conv(padded_curve(:,1), gaussian', 'valid');
smoothed_y = conv(padded_curve(:,2), gaussian', 'valid');

% Combine the smoothed x and y coordinates into a single matrix
smoothed_curve = [smoothed_x, smoothed_y];
end
