function [y, hex] = color_cool_blue(varargin)
 hex = '#205493';
 if isempty(varargin)
    y = hex2rgb(hex);
 else
    y = hex2rgb(hex,varargin{1});
 end
end