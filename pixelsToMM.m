function [ mm ] = pixelsToMM (px, dpi)
% Converts pixels to mm
% px, number of pixels
% dpi, dots per inch of the image 
% 25.4 mm in an inch
    mm = (px * 25.4) / dpi;
end
