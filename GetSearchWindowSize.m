function [ ssize ] = GetSearchWindowSize( f, z, b )
%GetSearchWindowSize a function to calculate the optimal search window size
%f = focul length, 50mm
%z = min depth of object 1000 = 1 meter, 
x = 1; %any value of x will produce the same result
%b = baseline, 300 = 30cm
dpi =72;


xr = (f / z) * (x-b);
xl = (f / z) * x;
mm = abs(xl - xr) * 2;
ssize = (mm * dpi) / 25.4;
end

