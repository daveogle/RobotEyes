function [ result ] = GetSearchDisparityMap( image1, image2, support_size, search_size, diffType )
    
    halfSearch =  floor(search_size / 2);
    [imageBoundX, imageBoundY,~] = size(image1);
    cost = cell(imageBoundX, imageBoundY);
    [cost{:}] = deal([-1,0,0]);
    minW = -halfSearch;
    W = halfSearch;
    
    for i = minW : W
        for j = minW : W
            disp_map = zeros(imageBoundX, imageBoundY);
            for x = 1 : imageBoundX
                for y = 1 : imageBoundY
                    if (x+i > 0 && y+j > 0) && (x+i <= imageBoundX && y+j <= imageBoundY)
                        disp_map(x,y) = SUPPORT_CMP(image1, image2, [x,y], [x+i, y+j], 0, diffType);%SSD(image1(x,y), image2(x+i, y+j)); 
                    end
                end
            end
            ii = integralImage(disp_map);
            ii(1,:) = [];
            ii(:,1) = [];
            for x = 1 : imageBoundX
                for y = 1 : imageBoundY
                    if (x+i > 0 && y+j > 0) && (x+i <= imageBoundX && y+j <= imageBoundY)
                        temp = SumRegion(ii, [x,y], support_size);
                        current = cost{x,y};
                        if temp < current(1) || current(1) < 0
                            cost{x,y} = [temp, i, j];
                        end
                    end
                end
            end
        end
    end
    result = extractDimension(cost);
end

