function [ disp_map ] = ComputeDisparityMap( image1, image2, supportSize, searchWindowSize, diffType )
    [imagex,imagey] = size(image1);    
    disp_map = zeros(imagex,imagey);
    
    %pad the images with the size of the support window
    halfSupport = floor(supportSize /2);
    pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
    pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');
    
    for x = 1 : imagex
        for y = 1 : imagey
        result = PIXEL_DISP(pImage1, pImage2, [x,y], supportSize, searchWindowSize, diffType); 
        disp_map(x,y) = sqrt((x-result(1))^2 + (y-result(2))^2);
        end
    end
end

