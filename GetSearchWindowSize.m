function [ ssize ] = GetSearchWindowSize( f, z, b )
%GetSearchWindowSize a function to calculate the optimal search window size
%f = focul length, 0.05 = 50mm
%z = min depth of object 1 = 1M, 
x = 1; %any value of x will produce the same result
%b = baseline, 0.3 = 30cm

xr = (f / z) * (x-b);
xl = (f / z) * x;
ssize = abs(xl - xr) * 2;
end

