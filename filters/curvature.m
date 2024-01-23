function k=curvature(Vertices,Lines)
    % This function calculates the curvature of a 2D line. It first fits 
    % polygons to the points. Then calculates the analytical curvature from
    % the polygons;
    %
    %  k = LineCurvature2D(Vertices,Lines)
    % 
    % inputs,
    %   Vertices : A M x 2 list of line points.
    %   (optional)
    %   Lines : A N x 2 list of line pieces, by indices of the vertices
    %         (if not set assume Lines=[1 2; 2 3 ; ... ; M-1 M])
    %
    % outputs,
    %   k : M x 1 Curvature values
    %
    %
    %
    % Example, Circle
    %  r=sort(rand(15,1))*2*pi;
    %  Vertices=[sin(r) cos(r)]*10;
    %  Lines=[(1:size(Vertices,1))' (2:size(Vertices,1)+1)']; Lines(end,2)=1;
    %  k=LineCurvature2D(Vertices,Lines);
    %
    %  figure,  hold on;
    %  N=LineNormals2D(Vertices,Lines);
    %  k=k*100;
    %  plot([Vertices(:,1) Vertices(:,1)+k.*N(:,1)]',[Vertices(:,2) Vertices(:,2)+k.*N(:,2)]','g');
    %  plot([Vertices(Lines(:,1),1) Vertices(Lines(:,2),1)]',[Vertices(Lines(:,1),2) Vertices(Lines(:,2),2)]','b');
    %  plot(sin(0:0.01:2*pi)*10,cos(0:0.01:2*pi)*10,'r.');
    %  axis equal;
    %
    % Example, Hand
    %  load('testdata');
    %  k=LineCurvature2D(Vertices,Lines);
    %
    %  figure,  hold on;
    %  N=LineNormals2D(Vertices,Lines);
    %  k=k*100;
    %  plot([Vertices(:,1) Vertices(:,1)+k.*N(:,1)]',[Vertices(:,2) Vertices(:,2)+k.*N(:,2)]','g');
    %  plot([Vertices(Lines(:,1),1) Vertices(Lines(:,2),1)]',[Vertices(Lines(:,1),2) Vertices(Lines(:,2),2)]','b');
    %  plot(Vertices(:,1),Vertices(:,2),'r.');
    %  axis equal;
    %
    % Function is written by D.Kroon University of Twente (August 2011)
    % If no line-indices, assume a x(1) connected with x(2), x(3) with x(4) ...
    if(nargin<2)
        Lines=[(1:(size(Vertices,1)-1))' (2:size(Vertices,1))'];
    end
    % Get left and right neighbor of each points
    Na=zeros(size(Vertices,1),1); Nb=zeros(size(Vertices,1),1);
    Na(Lines(:,1))=Lines(:,2); Nb(Lines(:,2))=Lines(:,1);
    % Check for end of line points, without a left or right neighbor
    checkNa=Na==0; checkNb=Nb==0;
    Naa=Na; Nbb=Nb;
    Naa(checkNa)=find(checkNa); Nbb(checkNb)=find(checkNb);
    % If no left neighbor use two right neighbors, and the same for right... 
    Na(checkNa)=Nbb(Nbb(checkNa)); Nb(checkNb)=Naa(Naa(checkNb));
    % Correct for sampeling differences
    Ta=-sqrt(sum((Vertices-Vertices(Na,:)).^2,2));
    Tb=sqrt(sum((Vertices-Vertices(Nb,:)).^2,2)); 
    % If no left neighbor use two right neighbors, and the same for right... 
    Ta(checkNa)=-Ta(checkNa); Tb(checkNb)=-Tb(checkNb);
    % Fit a polygons to the vertices 
    % x=a(3)*t^2 + a(2)*t + a(1) 
    % y=b(3)*t^2 + b(2)*t + b(1) 
    % we know the x,y of every vertice and set t=0 for the vertices, and
    % t=Ta for left vertices, and t=Tb for right vertices,  
    x = [Vertices(Na,1) Vertices(:,1) Vertices(Nb,1)];
    y = [Vertices(Na,2) Vertices(:,2) Vertices(Nb,2)];
    M = [ones(size(Tb)) -Ta Ta.^2 ones(size(Tb)) zeros(size(Tb)) zeros(size(Tb)) ones(size(Tb)) -Tb Tb.^2];
    invM=inverse3(M);
    a(:,1)=invM(:,1,1).*x(:,1)+invM(:,2,1).*x(:,2)+invM(:,3,1).*x(:,3);
    a(:,2)=invM(:,1,2).*x(:,1)+invM(:,2,2).*x(:,2)+invM(:,3,2).*x(:,3);
    a(:,3)=invM(:,1,3).*x(:,1)+invM(:,2,3).*x(:,2)+invM(:,3,3).*x(:,3);
    b(:,1)=invM(:,1,1).*y(:,1)+invM(:,2,1).*y(:,2)+invM(:,3,1).*y(:,3);
    b(:,2)=invM(:,1,2).*y(:,1)+invM(:,2,2).*y(:,2)+invM(:,3,2).*y(:,3);
    b(:,3)=invM(:,1,3).*y(:,1)+invM(:,2,3).*y(:,2)+invM(:,3,3).*y(:,3);
    % Calculate the curvature from the fitted polygon
    k = 2*(a(:,2).*b(:,3)-a(:,3).*b(:,2)) ./ ((a(:,2).^2+b(:,2).^2).^(3/2));
    function  Minv  = inverse3(M)
    % This function does inv(M) , but then for an array of 3x3 matrices
    adjM(:,1,1)=  M(:,5).*M(:,9)-M(:,8).*M(:,6);
    adjM(:,1,2)=  -(M(:,4).*M(:,9)-M(:,7).*M(:,6));
    adjM(:,1,3)=  M(:,4).*M(:,8)-M(:,7).*M(:,5);
    adjM(:,2,1)=  -(M(:,2).*M(:,9)-M(:,8).*M(:,3));
    adjM(:,2,2)=  M(:,1).*M(:,9)-M(:,7).*M(:,3);
    adjM(:,2,3)=  -(M(:,1).*M(:,8)-M(:,7).*M(:,2));
    adjM(:,3,1)=  M(:,2).*M(:,6)-M(:,5).*M(:,3);
    adjM(:,3,2)=  -(M(:,1).*M(:,6)-M(:,4).*M(:,3));
    adjM(:,3,3)=  M(:,1).*M(:,5)-M(:,4).*M(:,2);
    detM=M(:,1).*M(:,5).*M(:,9)-M(:,1).*M(:,8).*M(:,6)-M(:,4).*M(:,2).*M(:,9)+M(:,4).*M(:,8).*M(:,3)+M(:,7).*M(:,2).*M(:,6)-M(:,7).*M(:,5).*M(:,3);
    Minv=bsxfun(@rdivide,adjM,detM);
    


% function [k,R,L] = curvature(X)
%     % Radius of curvature and curvature vector for 2D or 3D curve
%     %  [L,R,k] = curvature(X)
%     %   X:   2 or 3 column array of x, y (and possibly z) coordiates
%     %   L:   Cumulative arc length
%     %   R:   Radius of curvature
%     %   k:   Curvature vector
%     % The scalar curvature value is 1./R
%     % Version 2.6: Calculates end point values for closed curve
%       N = size(X,1);
%       dims = size(X,2);
%       if dims == 2
%         X = [X,zeros(N,1)];  % Use 3D expressions for 2D as well
%       end
%       L = zeros(N,1);
%       R = zeros(N,1);
%       k = zeros(N,3);
%       for i = 2:N-1
%         [R(i),~,k(i,:)] = circumcenter(X(i,:)',X(i-1,:)',X(i+1,:)');
%         L(i) = L(i-1)+norm(X(i,:)-X(i-1,:));
%       end
%       if norm(X(1,:)-X(end,:)) < 1e-10 % Closed curve. 
%         [R(1),~,k(1,:)] = circumcenter(X(end-1,:)',X(1,:)',X(2,:)');
%         R(end) = R(1);
%         k(end,:) = k(1,:);
%         L(end) = L(end-1) + norm(X(end,:)-X(end-1,:));
%       end
%       i = N;
%       L(i) = L(i-1)+norm(X(i,:)-X(i-1,:));
%       if dims == 2
%         k = k(:,1:2);
%       end
% end    

% function [R,M,k] = circumcenter(A,B,C)
%     % Center and radius of the circumscribed circle for the triangle ABC
%     %  A,B,C  3D coordinate vectors for the triangle corners
%     %  R      Radius
%     %  M      3D coordinate vector for the center
%     %  k      Vector of length 1/R in the direction from A towards M
%     %         (Curvature vector)
%       D = cross(B-A,C-A);
%       b = norm(A-C);
%       c = norm(A-B);
%       if nargout == 1
%         a = norm(B-C);     % slightly faster if only R is required
%         R = a*b*c/2/norm(D);
%         if norm(D) == 0
%           R = Inf;
%         end
%         return
%       end
%       E = cross(D,B-A);
%       F = cross(D,C-A); 
%       G = (b^2*E-c^2*F)/norm(D)^2/2;
%       M = A + G;
%       R = norm(G);  % Radius of curvature
%       if R == 0
%         k = G;
%       elseif norm(D) == 0
%         R = Inf;
%         k = D;
%       else
%         k = G'/R^2;   % Curvature vector
%       end
% end