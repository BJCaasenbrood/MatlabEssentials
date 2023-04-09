function h = fquiver(X,U,varargin)

    if size(X,2) == 2
        h = quiver(X(:,1),X(:,2),varargin{:});
    % elseif size(X,2) == 3 && size(X,3) > 1
    %     h = plot3(squeeze(X(:,1,:)),squeeze(X(:,2,:)),squeeze(X(:,3,:)),varargin{:});
    else
        h = quiver3(X(:,1),X(:,2),X(:,3),...
                    U(:,1),U(:,2),U(:,3),...
                    varargin{:});
    end
    end
    
    