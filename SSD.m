function [ result ] = SSD( w1, w2 )
    result = (w1 - w2).^2;
    result = sum(result(:));
end

