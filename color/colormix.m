function Color = colormix(C1,C2,x)
a1 = clamp(x,0,1);
a2 = clamp(1-x,0,1);

Color1 = srgbcompanding(C1,1);
Color2 = srgbcompanding(C2,1);

r = Color1(1)*a1 + Color2(1)*a2;
g = Color1(2)*a1 + Color2(2)*a2;
b = Color1(3)*a1 + Color2(3)*a2;

Color = [r,g,b];

Color = srgbcompanding(Color,0);
end