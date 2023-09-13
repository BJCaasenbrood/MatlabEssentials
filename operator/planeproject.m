function Y = planeproject(n1, n2, z)
    % Check if the input vectors have the correct dimensions
    if ~isequal(size(n1), size(n2), size(z))
        error('Input vectors must have the same dimensions.');
    end
    
    % Calculate the normal vector of the plane
    Nv = cross(n1, n2);
    
    if all(Nv == 0)
        error('The plane defined by the input vectors is degenerate.');
    else
        N = Nv / norm(Nv);
    end
    
    % Project the vector onto the plane
    Y = z - dot(z, N) * N;
end

