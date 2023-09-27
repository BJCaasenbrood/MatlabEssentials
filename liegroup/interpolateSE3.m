% INTERPOLATESE3 Interpolates between two SE(3) transformations.
%
%   Z = interpolateSE3(X,Y,t) interpolates between two SE(3) transformations X and Y
%   using a parameter t. The resulting transformation is returned in Z.
%
%   Z = interpolateSE3(X,Y,t,varargin) allows additional options to be specified
%   through varargin. Currently supported options are:
%     - 'equal': Sets the velocity twist equal between X and Y.
%     - 'zero': Sets the velocity and acceleration twist zero for X.
%
%   Input:
%     X - The initial SE(3) transformation.
%     Y - The final SE(3) transformation.
%     t - The interpolation parameter (between 0 and 1).
%     varargin - Additional options for interpolation (optional).
%
%   Output:
%     Z - The interpolated SE(3) transformation.
%
%   Example: 
%     H1 = SE3(rotx(0),[0,0,0]);
%     H2 = SE3(rotx(pi/3) * roty(pi*0.9999),[1,0,1])
% 
%     [p1,ux1,uy1,uz1] = backbone(H1);
%     fquiver(p1,ux1,.25,'b','LineW',3); hold on;
%     fquiver(p1,uy1,.25,'r','LineW',3); 
%     fquiver(p1,uz1,.25,'g','LineW',3); 
% 
%     [p2,ux2,uy2,uz2] = backbone(H2);
%     fquiver(p2,ux2,.25,'b','LineW',3); hold on;
%     fquiver(p2,uy2,.25,'r','LineW',3); 
%     fquiver(p2,uz2,.25,'g','LineW',3); 
% 
%     axis equal;
%     t = linspace(0,1,10);
% 
%     for ii = 2:numel(t)-1
%         G = interpolateSE3(H1,H2,t(ii),'zeros');
%         [p2,ux2,uy2,uz2] = backbone(G);
%         fquiver(p2,ux2,.15,'b','LineW',2); hold on;
%         fquiver(p2,uy2,.15,'r','LineW',2); 
%         fquiver(p2,uz2,.15,'g','LineW',2); 
%     end
% 
%     view(30,30);
% 
%   See also logmapSO3, expmapSO3
%
%   Reference: F.C. Park, Smooth Invariant Interpolation of Rotations.

function Z = interpolateSE3(X,Y,t,varargin)

    if ~isempty(varargin)
        switch varargin{1}
            case 'equal', t = 3*t^2 - 2*t^3; % velocity twist equal between X and Y
            case 'zero',  t = t^3; % velocity and acceleration twist zero for X
        end
    end

    dH = Y / X;
    R = dH(1:3,1:3);
    T = dH(1:3,4);

    % get log of rotation matrix
    S = logmapSO3(R);
    th = norm([S(3,2); S(1,3); S(2,1)]);

    if abs(th) < 1e-9;
        eps = 1e-6;
        S = logmapSO3(R*rotx(pi * rand *eps)*roty(pi * rand *eps));
        th = norm([S(3,2); S(1,3); S(2,1)]);
    end
    Vi = eye(3) - 0.5 * S + (1/(th^2)) * (1 - (th*sin(th))/(2*(1-cos(th))))*(S*S);
    U  = Vi * T;

    tth = t*th;
    Rt = expmapSO3(t * S);
    Vt = eye(3) + ((1-cos(tth))/(tth)^2)*(t*S) + ((tth - sin(tth))/((tth)^3)) * (t*S) * (t*S);

    Tt = t * Vt * U;
    Z = ([Rt,Tt;0,0,0,1]) * X;

end


function Y = logmapSO3(X)
    S = X;
    theta = acos(0.5*(trace(S) - 1));
    alpha = 0.5*theta/sin(theta);
    
    if ~isnan(alpha)
       Y = alpha*(S - S.'); 
    else
       Y = zeros(3); 
    end
end

function Y = expmapSO3(X)
    S = X;
    X = [S(3,2); S(1,3); S(2,1)];

    t = norm(X);
    if abs(t) >= 1e-12
        a = sin(t)/t;
        b = (1-cos(t))/(t*t);
        
        Y = eye(3) + a*S + b*S*S;
    else
        Y = eye(3);
    end
end
