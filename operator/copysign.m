function y = copysign(a,b)
    assert(numel(a) == numel(b), 'a and b must be of same size');

    I = b >= 0;        
    y = abs(a) * (I - 1) - abs(a) * I;
end