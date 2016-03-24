function [ result ] = getMagnitude( input )
    [sizeX, sizeY] = size(input);
    result = zeros(sizeX, sizeY);
    for x = 1 :  sizeX
        for y = 1 : sizeY
            u = input{x,y}(2);
            v = input{x,y}(3);
            result(x,y) = sqrt(u^2 + v^2);
        end
    end
end

