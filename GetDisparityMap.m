function [ map ] = GetDisparityMap( image1, image2, support_size, search_size, method, difference )
%image1 = left image
%image2 = right image
%support_size = support window size
%search_size = search window size
%method = 'ep' : epipolar, 'ii' : integral Image, 'n' : nieve
%difference = 'SSD' : sum of squared difference, 'SAD' : 'sum of absolute
%difference, 'E' : Euclidan

close all
map = zeros(size(image1));
if strcmp(method, 'ep')
    map = EpipolarDisparity(image1, image2, 100, support_size, search_size, difference);
elseif strcmp(method, 'ii')
    map = IntegralImageDisparity(image1, image2, support_size, search_size, difference);
elseif strcmp(method, 'n')
    map = NieveDisparity( image1, image2, support_size, search_size, difference);
else
    'Not a valid method'
end
maxV = max(max(map));
minV = min(min(map));
figure
imshow(map, [minV maxV])
colorbar
title(strcat('Disparity Map using :',  method));
end

