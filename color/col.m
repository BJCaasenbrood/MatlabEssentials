function color  = col(n,per)
cmap = colororder;

if nargin < 2
    per = 1;
end

ColorNew = srgbcompanding(cmap(n,:),0);
ColorNull = srgbcompanding([1,1,1],0);
color = colormix(ColorNew,ColorNull,per);
color = srgbcompanding(color,1);

end