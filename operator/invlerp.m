%INVLERP Inverse linear interpolation.
%
%   Y = INVLERP(V, A, B) computes the inverse linear interpolation of a
%   value V between the two endpoints A and B. The result Y is the relative
%   position of V between A and B, such that Y=0 corresponds to V=A and
%   Y=1 corresponds to V=B. V, A, and B can be scalar, vector, or matrix.
%
%   Example:
%       % Compute the inverse linear interpolation of 7 between 5 and 10.
%       y = invlerp(7, 5, 10);
%         = 0.4 % the integer 7 is 40% away from 5 and 60% away from 10
%
%   See also LERP.


function y = invlerp(v,a,b)
y = (v-a)/(b-a);
end
