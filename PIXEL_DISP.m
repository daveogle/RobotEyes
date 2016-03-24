function [ coords ] = PIXEL_DISP( image1, image2, support_location, support_size, search_size, diffType)
%PIXEL_DISP compare depth of each pixel in a search window against the
%given support_pixel and return a matrix of values.
%Image 1 & 2 are the images
%support location is the center pixel of the support window
%support size is the width of the support window (*Must be an odd number)
%search location is the center pixel of the searchwindow (Entire search
%window must be within image bounds)
%search size is the width of the search window (*Must be an odd number)
coords = support_location;
halfSearch =  floor(search_size / 2);
halfSupport = floor(support_size /2);
best_match = 99999;

[imageBoundX, imageBoundY,~] = size(image1);

%compensate for padding
support_location(1) = support_location(1) + halfSupport;
support_location(2) = support_location(2) + halfSupport;

search_location = support_location;

search_Xmin = search_location(1) - halfSearch;
search_Ymin = search_location(2) - halfSearch;
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

%for each pixel in the search window
for x=search_Xmin : search_Xmax
    for y =search_Ymin : search_Ymax
        %call the support window comparison
        a = SUPPORT_CMP(image1, image2, support_location, [x, y], halfSupport, diffType);
        if  abs(a) < abs(best_match)
            best_match = a;
            coords = support[x,y];
        end
    end
end
end