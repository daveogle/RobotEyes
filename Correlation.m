function [ result ] = Correlation( image1, image2, originPoint, searchPoints, supportSize )

[searchBoundsX, searchBoundsY] = size(searchPoints);
halfSupport = floor(supportSize /2);

minDiff = 9999;
result = zeros(1,3);

    for x = 1 : searchBoundsX
       diff = SUPPORT_CMP(image1, image2, originPoint, searchPoints(x), halfSupport);
       if diff < minDiff
        result = [searchPoints(x), diff];
       end
    end
end

