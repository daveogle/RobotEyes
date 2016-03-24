function [ result ] = Correlation( image1, image2, originPoint, searchPoints, supportSize, diffType )

[searchBoundsX,] = size(searchPoints);
halfSupport = floor(supportSize /2);
pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');

minDiff = -1;
result = zeros(1,3);

    for x = 1 : searchBoundsX
       diff = SUPPORT_CMP(pImage1, pImage2, (originPoint + halfSupport), (searchPoints(x,:) + halfSupport), halfSupport, diffType);
       if minDiff < 0 || diff < minDiff
        minDiff = diff;
        result = [searchPoints(x,:), diff];
       end
    end
end

