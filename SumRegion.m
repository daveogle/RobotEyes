function [ cost ] = SumRegion(ii, p, r)
    halfr = floor(r / 2);
    [sizeX, sizeY] = size(ii);
    corners = [[p(1) - halfr, p(2) - halfr]; ...
        [p(1) + halfr, p(2) - halfr]; [p(1) - halfr, p(2) + halfr]; ...
        [p(1) + halfr, p(2) + halfr]];
    
    for i=1:4
        if corners(i,1) <= 0
            corners(i,1) = 1;
        end
        if corners(i,2) <= 0
            corners(i,2) = 1;
        end
        if corners(i,1) > sizeX
            corners(i,1) = sizeX;
        end
        if corners(i,2) >sizeY
            corners(i,2) = sizeY;
        end
    end
    cost = ii(corners(1,1), corners(1,2)) + ii(corners(4,1), corners(4,2))...
        - (ii(corners(2,1), corners(2,2)) + ii(corners(3,1), corners(3,2)));
end