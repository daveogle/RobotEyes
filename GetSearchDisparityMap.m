function [ result ] = GetSearchDisparityMap( image1, image2, support_size, search_size )
    
    halfSearch =  floor(search_size / 2);
    [imageBoundX, imageBoundY,z] = size(image1);
    cost = cell(imageBoundX, imageBoundY);
    disp_map = zeros(imageBoundX, imageBoundY);
    minW = -halfSearch;
    W = halfSearch;
    
    for i = minW : W
        for j = minW : W
            for x = 1 : imageBoundX
                for y = 1 : imageBoundY
                    if (x+i > 0 && y+j > 0) && (x+i <= imageBoundX && y+j <= imageBoundY)
                        disp_map(x,y) = SSD(image1(x,y), image2(x+i, y+j)); 
                    end
                end
            end
            ii = integralImage(disp_map);
            for x = 1 : imageBoundX
                for y = 1 : imageBoundY
                    if i == minW && j == minW
                        cost{x,y} = [SumRegion(ii, [x,y], support_size), i, j];
                    else
                        temp = SumRegion(ii, [x,y], support_size);
                        current = cost{x,y};
                        if current(1) > temp || (current(1) == 0 && temp ~= 0)
                            cost{x,y} = [temp, i, j];
                        end
                    end
                end
            end
        end
    end
    result = extractDimension(cost);
    imshow(result);
end

