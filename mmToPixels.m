function [ px ] = mmToPixels (mm, dpi)
% Converts mm to pixels
% mm, number of millimeters
% dpi, dots per inch of the image 
% 25.4 mm in an inch
    px = (mm * dpi) / 25.4;
end