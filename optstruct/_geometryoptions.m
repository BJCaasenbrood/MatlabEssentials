classdef geometryoptions
    
    properties
        Node;
        Elements;
        % NNode;
        % NElem;
    end
    
    methods
        function obj = geometryoptions
            obj.Elements = [];
            obj.Node     = [];
            % obj.NNode    = 0;
            % obj.NElem    = 0;
        end

        function y = NElem(geom)
            y = length(geom.Elements);
        end

        function y = NNode(geom)
            y = length(geom.Node);
        end
    end
end

