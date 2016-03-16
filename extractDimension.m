function [ result ] = extractDimension( input )
    [sizeX, sizeY] = size(input);
    result = zeros(sizeX, sizeY);
    for x = 1 :  sizeX
        for y = 1 : sizeY
            u = input{x,y}(2);
            v = input{x,y}(3);
            %result(x,y) = abs(u(1)*v(2)-u(2)*v(1))*sin(90);
            result(x,y) = sqrt((u)^2 + (v)^2);
        end
    end
end

