function [ ssize ] = GetSearchWindowSize( f, z, b )
%GetSearchWindowSize a function to calculate the optimal search window size
%f = focul length, 50mm
%z = min depth of object 1000 = 1 meter, 
%b = baseline, 300 = 30cm
dpi =72;

xr = (f / z) * (-b);
mm = abs(xr) * 2;
ssize = (mm * dpi) / 25.4;
end

