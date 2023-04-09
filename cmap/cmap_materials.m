function colmap = bounce(n)
    colmap = ...
        [0.6532    0.9762    0.3084;
         0.2449    0.7218    0.9095;
         0.9774    0.5053    0.2085;
         1.0000    0.1608    0.4588;
         0.4471    0.3255    0.9294;
         0.8929    0.8929    0.8929];
    
    if nargin>0
        colmap = cmapping(colmap,n);
    end
    
    end
    
    function colmap = cmapping(colmap,arg)
    
    if arg > 1
        x = linspace(0,1,length(colmap));
        xq = linspace(0,1,arg);
        colmap = interp1(x,colmap,xq);
    elseif arg < 0
        if abs(arg) == 1, arg = 100; end
        x = linspace(0,1,length(colmap));
        xq = linspace(0,1,abs(arg));
        colmap = interp1(x,colmap,xq);
        colmap = flipud(colmap);
    elseif arg == 0
        colmap = [colmap;flipud(colmap)];
    end
    
    end