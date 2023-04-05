function colmap = chroma(alpha)
    I = imread('chroma.jpg');
    id = round(500*clamp(alpha,0,1));
    colmap = squeeze(I(id,:,:));
end

