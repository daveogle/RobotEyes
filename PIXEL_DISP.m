function [ depthmap ] = PIXEL_DISP( image1, image2, support_location, support_size, search_location, search_size)
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
depthmap = zeros(search_size, search_size);
map_x = 1;
map_y = 1;

%pad the images with the size of the support window
pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');

%compensate for padding
search_location(1) = search_location(1) + halfSupport;
search_location(2) = search_location(2) + halfSupport;

%for each pixel in the search window
for x=(search_location(1) - halfSearch) : (search_location(1) + halfSearch)
    for y =(search_location(2) - halfSearch) : (search_location(2) + halfSearch);
        %call the support window comparison
        depthmap(map_x, map_y) = SUPPORT_CMP(pImage1, pImage2, support_location, [x, y], support_size);
        map_y = map_y + 1;
    end
    map_y = 1;
    map_x = map_x + 1;
end
end