function set_colororder(varargin)
if isempty(varargin)
    cmap = cpal_nasa;
else
    cmap = varargin{1};
end
set(gca,'defaultAxesColorOrder',cmap);
colororder(cmap)
end