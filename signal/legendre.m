function y = legendre(x,n)
x = (2*x-1);

if (n==0),      y = 1 + x*0;
elseif(n==1),   y = x;
elseif(n==2),   y = 0.5*(3*x.^2 - 1);
elseif(n==3),   y = 0.5*(5*x.^3 - 3*x);
elseif(n==4),   y = 0.125*(35*x.^4 - 30*x.^2 + 3);
elseif(n==5),   y = 0.125*(63*x.^5 - 70*x.^3 + 15*x);
elseif(n==6),   y = 0.0625*(231*x.^6 - 315*x.^4 + 105*x.^2 -5);
elseif(n==7),   y = 0.0625*(429*x.^7 - 693*x.^5 + 315*x.^3 - 35*x);
elseif(n==8),   y = 0.0078125*(6435*x.^8 - 12012*x.^6 + 6930*x.^4- 1260*x.^2 + 35);
else,           y = 1 + x*0;
end
end


