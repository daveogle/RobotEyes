function [ map ] = EpipolarDisparity( image1, image2, support_size, searchWinSize )

map = zeros(size(image1));
halfSupport = floor(support_size /2);
halfSearch = floor(searchWinSize /2);
%compute fundemental matrix
matchedPoints = cornerCorrelation(image1, image2, 10, support_size, searchWinSize);
matchedPoints1 = matchedPoints(:,1 : 2);
matchedPoints2 = matchedPoints(:,3 : 4);

%F = estimateFundamentalMatrix(matchedPoints1, matchedPoints2, 'Method','Norm8Point');

%CODE TO SHOW THE EPIPOLAR LINES
%[fLMedS, inliers]
F = estimateFundamentalMatrix(matchedPoints1, matchedPoints2, 'Method','Norm8Point');
%     figure;
%     subplot(121); imshow(image1);
%     title('Inliers and Epipolar Lines in First Image'); hold on;
%     plot(matchedPoints1(inliers,1), matchedPoints1(inliers,2), 'go')
%     epiLines = epipolarLine(fLMedS', matchedPoints2(inliers, :));
%     points = lineToBorderPoints(epiLines, size(image1));
%     line(points(:, [1,3])', points(:, [2,4])');
%
%     subplot(122); imshow(image2);
%     title('Inliers and Epipolar Lines in Second Image'); hold on;
%     plot(matchedPoints2(inliers,1), matchedPoints2(inliers,2), 'go')
%     epiLines = epipolarLine(fLMedS, [5,7]);
%     points = lineToBorderPoints(epiLines, size(image2));
%     line(points(:, [1,3])', points(:, [2,4])');
%     truesize;

[imageRow, imageCol] = size(image1);
%pad images for comparison
pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');
%get image co-ords
coords = getImageCoords(image1);
%find epipolar line
epiLines = epipolarLine(F, coords);
%extract point start and end coords
points = lineToBorderPoints(epiLines, size(image2));
count = 1;
%for every x,y in the image (epipolar line takes [column, row]
for x = 1 : imageCol
    minW = x - halfSearch;
    maxW = x + halfSearch;
    if minW < 1
        minW = 1;
    end
    if maxW > imageCol
        maxW = imageCol;
    end
    for y = 1 : imageRow
        best = -1;
        %get the points on the line padded by 1 pixel in the y axis
        pointsOnLine = bresenham(points(count, 1), points(count, 2), points(count, 3), points(count, 4));
        %for each point
        for i = 1 : length(pointsOnLine)
            %if within search window
            if pointsOnLine(i,1) > 0 && pointsOnLine(i,1) <= imageCol && pointsOnLine(i,1) > minW && pointsOnLine(i,1) <= maxW
                cost = SUPPORT_CMP(pImage1, pImage2, [imageRow, imageCol] + halfSupport, [pointsOnLine(i,2),pointsOnLine(i,1)] + halfSupport, halfSupport);
                if best == -1 || cost < best
                    best = cost;
                end
            end
        end
        map(y,x) = best;
        count = count + 1;
    end
end
end

function [coords] = getImageCoords(image)
    [rowMax, colMax] = size(image);
    coords = zeros((rowMax * colMax), 2);
    coordsNumber = 1;
    for row = 1 : rowMax
        for col = 1 : colMax
            coords(coordsNumber,:) = [col, row];
            coordsNumber = coordsNumber + 1;
        end
    end
end


