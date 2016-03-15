function [ result ] = GetSearchDisparityMap( image1, image2, support_center, support_size, search_size )
    
    halfSupport = floor(support_size /2);
    halfSearch =  floor(search_size / 2);


    %pad the images with the size of the support window
    pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
    pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');
    [imageBoundX, imageBoundY,z] = size(image1);

    %disp_map = zeros(search_size, search_size);
    cost = cell(imageBoundX, imageBoundY);
    map_x = 1;
    map_y = 1;

    %compensate for padding
    support_center(1) = support_center(1) + halfSupport;
    support_center(2) = support_center(2) + halfSupport;

    %adjust search window size to account for OOBX
    search_Xmin = support_center(1) - halfSearch;
    search_Ymin = support_center(2) - halfSearch;
    if(search_Xmin < (1 + halfSupport)) %top
        search_Xmin = (1 + halfSupport);
    end
    if(search_Ymin < (1 + halfSupport)) %top
        search_Ymin = (1 + halfSupport);
    end

    search_Xmax = search_Xmin + search_size -1;
    search_Ymax = search_Ymin + search_size -1;
    if(search_Xmax > (imageBoundX - halfSupport))
        search_Xmax = (imageBoundX - halfSupport);
    end
    if(search_Ymax > (imageBoundY - halfSupport))
        search_Ymax = (imageBoundY - halfSupport);
    end
    
    minW = -halfSearch;
    W = halfSearch;
    dist = zeros(imageBoundX, imageBoundY);
    %for each pixel in the search window (for OFF exists in Offsets)
    for i = minW : W
        for j = minW : W
            for x = 1 : imageBoundX
                for y = 1 : imageBoundY
                    if (x+i > 0 && y+j > 0) && (x+i <= imageBoundX && y+j <= imageBoundY)
                        dist(x,y) = SSD(image1(x,y), image2(x+i, y+j)); 
                    end
                end
            end
            ii = integralImage(dist);
            ii(1,:) = [];
            ii(:,1) = [];
            for x = 1 : imageBoundX
                for y = 1 : imageBoundY
                    if i == minW && j == minW
                        cost{x,y} = [SumRegion(ii, [x,y], search_size), i, j];
                    else
                        temp = SumRegion(ii, [x,y], search_size);
                        current = cost{x,y};
                        if current(1) > temp || current(1) == 0
                            cost{x,y} = [temp, i, j];
                        end
                    end
                end
            end
        end
        map_y = 1;
        map_x = map_x + 1;
    end
    result = extractDimension(cost);
    figure
    imshow(result);
end

