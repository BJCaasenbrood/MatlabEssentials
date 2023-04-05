function varargout = tplane(x,y,z,varargin)
tri = delaunay(x,y);

h = trisurf(tri, x, y, z,varargin{:});
if nargout > 1
    varargout = {h, tri};
end

end

