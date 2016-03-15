function [ disp_map ] = PIXEL_DISP( image1, image2, support_location, support_size, search_size)
%PIXEL_DISP compare depth of each pixel in a search window against the
%given support_pixel and return a matrix of values.
%Image 1 & 2 are the images
%support location is the center pixel of the support window
%support size is the width of the support window (*Must be an odd number)
%search location is the center pixel of the searchwindow (Entire search
%window must be within image bounds)
%search size is the width of the search window (*Must be an odd number)

halfSearch =  floor(search_size / 2);
halfSupport = floor(support_size /2);

%pad the images with the size of the support window
pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');
[imageBoundX, imageBoundY,z] = size(pImage1);

disp_map = zeros(search_size, search_size);
map_x = 1;
map_y = 1;

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
        disp_map(map_x, map_y) = SUPPORT_CMP(pImage1, pImage2, support_location, [x, y], support_size);
        map_y = map_y + 1;
    end
    map_y = 1;
    map_x = map_x + 1;
end
image(disp_map)
end