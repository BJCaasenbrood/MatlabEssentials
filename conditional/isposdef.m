function isposdef = isposdef(A,varargin)

    tol = eps;   
    if ~isempty(varargin)
        tol = varargin{1};
    end

    % Check if the matrix is square
    [m, n] = size(A);
    if m ~= n
        error('Input matrix must be square.');
    end

    if ~isequal(A, A.')
        isposdef = true;
        [~, p] = chol(A);
        if p ~= 0
            isposdef = false;
        end
    else
        d = eig(A);
        isposdef = all(d > tol);
    end
end
