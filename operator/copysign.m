function y = copysign(a,b)
    I = b >= 0;        
    y = abs(a) .* I - abs(a) .* (1-I);
end
