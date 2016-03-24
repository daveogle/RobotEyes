function [ map ] = EpipolarDisparity( image1, image2, corners, support_size, searchWinSize, diffType )

halfSupport = floor(support_size /2);
halfSearch = floor(searchWinSize /2);
[sizeX, sizeY] = size(image1);
%compute fundemental matrix
[matchedPoints1, matchedPoints2] = cornerCorrelation(image1, image2, corners, support_size, searchWinSize, diffType);
m1 = matchedPoints1.Location;
m2 = matchedPoints2.Location;

%CODE TO SHOW THE EPIPOLAR LINES
[F, inliers, status] = estimateFundamentalMatrix(matchedPoints1, matchedPoints2, 'Method', 'LMedS');
if status ~=0
    1
end

inlierPoints1 = matchedPoints1(inliers, :);
inlierPoints2 = matchedPoints2(inliers, :);

figure;
showMatchedFeatures(image1, image2, inlierPoints1, inlierPoints2);
legend('Inlier points in I1', 'Inlier points in I2');

%get line coords
%get image co-ords
results = zeros(sizeX,sizeY);
%Show charts

figure;
subplot(121); imshow(image1);
title('Matched points and Epipolar Lines in First Image'); hold on;
plot(m1(inliers,1), m1(inliers,2), 'go')
epiLines = epipolarLine(F', m2(inliers, :));
points = lineToBorderPoints(epiLines, size(image1));
line(points(:, [1,3])', points(:, [2,4])');

subplot(122); imshow(image2);
title('Matched points and Epipolar Lines in Second Image'); hold on;
plot(m2(inliers,1), m2(inliers,2), 'go')
epiLines = epipolarLine(F, m1(inliers, :));
points = lineToBorderPoints(epiLines, size(image2));
line(points(:, [1,3])', points(:, [2,4])');
truesize;

coords = getImageCoords(image1);
%find epipolar lines
epiLines = epipolarLine(F, coords);
points = lineToBorderPoints(epiLines, size(image1));

%pad images for comparison
pImage1 = padarray(image1, [halfSupport halfSupport], 0, 'both');
pImage2 = padarray(image2, [halfSupport halfSupport], 0, 'both');

for epLine = 1 : length(points);
    best = [0,0,-1];
    lineCoords = bresenham(points(epLine, 1), points(epLine, 2), points(epLine, 3), points(epLine, 4));
    if lineCoords(1) ~= -1
        for j = 1 : length(lineCoords)
            if lineCoords(j,1) <= sizeY && lineCoords(j,2) <= sizeX ...
                    && lineCoords(j,1) <= coords(epLine,1) + halfSearch && lineCoords(j,2) <= coords(epLine,2) + halfSearch ...
                    && lineCoords(j,1) >= coords(epLine,1) - halfSearch && lineCoords(j,2) >= coords(epLine,2) - halfSearch
                cost = SUPPORT_CMP(pImage1, pImage2, [coords(epLine,2),coords(epLine,1)] + halfSupport, [lineCoords(j,2),lineCoords(j,1)] + halfSupport, halfSupport, diffType);
                if best(3) == -1 || cost < best(3)
                    best = [lineCoords(j,1),lineCoords(j,2), cost];
                end
            end
        end
    end
    resultLeft = coords(epLine,:);
    resultRight = [best(1), best(2)];
    temp = resultLeft - resultRight;
    results(coords(epLine, 2), coords(epLine, 1)) = sqrt(temp(1)^2 + temp(2)^2);
end
map = results;
end

%return all coordinates in an image
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


