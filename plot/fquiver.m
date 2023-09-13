function h = fquiver(X,U,varargin)

if size(X,2) == 2
    h = quiver(X(:,1),X(:,2),U(:,1),U(:,2),varargin{:});
else
    h = quiver3(X(:,1),X(:,2),X(:,3),...
        U(:,1),U(:,2),U(:,3),...
        varargin{:});
end
end


