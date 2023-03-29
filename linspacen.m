%LINSPACEN Generate evenly spaced vectors between A and B.
%
% C = LINSPACEN(A, B, N) generates a row vector C containing N equally
% spaced points between A and B. If A and B are arrays of the same size,
% LINSPACEN generates an array C with the same shape as A and B, where each
% element of C is an array of N equally spaced points between the
% corresponding elements of A and B.
%
% Unlike MATLAB's built-in LINSPACE function, LINSPACEN supports generating
% vectors for each element of an array A or B, as well as generating
% multidimensional arrays of evenly spaced points.
%
% Note that the endpoints A and B are always included in the output C.
%
% Examples:
%   linspacen(1, 2, 3) returns [1 1.5 2].
%   linspacen([1 3], [2 4], 3) returns [1 1.5 2; 3 3.5 4].
%   linspacen([1 2; 3 4], [2 3; 4 5], 3) returns
%     [1.0000 1.5000 2.0000; 3.0000 3.5000 4.0000]
%     [2.0000 2.5000 3.0000; 4.0000 4.5000 5.0000].
%
% See also LINSPACE.


function C = linspacen(A,B,n)
N = size(A);

if ~all(size(A)==size(B)), error('A and B should be the same size'); end

if n==1
    C=B;
else
    logicReshape=~isvector(A);
   
    A = A(:);
    B = B(:);
    
    C=repmat(A,[1,n])+((B-A)./(n-1))*(0:1:n-1);
    
    %Force start and end to match (also avoids numerical precission issues) 
    C(:,1)=A; %Overide start
    C(:,end)=B; %Overide end
    if logicReshape
        C=reshape(C,[N n]);
    end
end
