function [ map ] = EpipolarDisparity( image1, image2, corners, support_size, searchWinSize )

halfSupport = floor(support_size /2);
halfSearch = floor(searchWinSize /2);
%compute fundemental matrix
[matchedPoints1, matchedPoints2] = cornerCorrelation(image1, image2, corners, support_size, searchWinSize);
m1 = matchedPoints1.Location;
m2 = matchedPoints2.Location;
%matchedPoints1 = matchedPoints(:,1 : 2);
%matchedPoints2 = matchedPoints(:,3 : 4);

%CODE TO SHOW THE EPIPOLAR LINES
%[fLMedS, inliers]
[F, inliers, status] = estimateFundamentalMatrix(matchedPoints1, matchedPoints2, 'Method', 'LMedS');
if status ~=0
1
end

inlierPoints1 = matchedPoints1(inliers, :);
inlierPoints2 = matchedPoints2(inliers, :);

figure;
showMatchedFeatures(image1, image2, inlierPoints1, inlierPoints2);
legend('Inlier points in I1', 'Inlier points in I2');

%rectify image
[T1,T2] = estimateUncalibratedRectification(F, inlierPoints1.Location, inlierPoints2.Location, size(image2));
tform1 = projective2d(T1);
tform2 = projective2d(T2);
[J1,J2] = rectifyStereoImages(image1, image2, tform1, tform2, 'OutputView','valid');
resultLeft = zeros(size(J1));
resultRight = zeros(size(J1));

%Show charts
figure;
imshow(stereoAnaglyph(J1,J2));

figure;
showMatchedFeatures(image1,image2,matchedPoints1,matchedPoints2,'montage','PlotOptions',{'ro','go','y--'});
title('Putative point matches');

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

[imageRow, imageCol] = size(J1);
%pad images for comparison
pImage1 = padarray(J1, [halfSupport halfSupport], 0, 'both');
pImage2 = padarray(J2, [halfSupport halfSupport], 0, 'both');

for row = 1 : imageRow
    
    for col = 1 : imageCol
        best = [0,0,-1];
        %set search window bounds
        minW = col - halfSearch;
        maxW = col + halfSearch;
        if minW < 1
            minW = 1;
        end
        if maxW > imageCol
            maxW = imageCol;
        end
        for x = minW : maxW
            cost = SUPPORT_CMP(pImage1, pImage2, [row, col] + halfSupport, [row,x] + halfSupport, halfSupport);
            if best(3) == -1 || cost < best(3)
                best = [col,x, cost];
            end
        end
        resultLeft(row,col) = best(1);
        resultRight(row,col) = best(2);
    end
end
map = resultLeft - resultRight;
maxV = max(max(map));
minV = min(min(map));
figure;
title('Disparity Map using Epipolar Lines');
imshow(map, [minV maxV])
end
%get image co-ords
%coords = getImageCoords(J1);
%find epipolar line
%epiLines = epipolarLine(F, coords);
%extract point start and end coords
%points = lineToBorderPoints(epiLines, size(image2));
% count = 1;
%for every x,y in the image (epipolar line takes [column, row]
% for x = 1 : imageCol
%     minW = x - halfSearch;
%     maxW = x + halfSearch;
%     if minW < 1
%         minW = 1;
%     end
%     if maxW > imageCol
%         maxW = imageCol;
%     end
%     for y = 1 : imageRow
%         best = -1;
%         %get the points on the line padded by 1 pixel in the y axis
%         pointsOnLine = bresenham(points(count, 1), points(count, 2), points(count, 3), points(count, 4));
%         %for each point
%         for i = 1 : length(pointsOnLine)
%             %if within search window
%             if pointsOnLine(i,1) > 0 && pointsOnLine(i,1) <= imageCol && pointsOnLine(i,1) > minW && pointsOnLine(i,1) <= maxW
%                 cost = SUPPORT_CMP(pImage1, pImage2, [imageRow, imageCol] + halfSupport, [pointsOnLine(i,2),pointsOnLine(i,1)] + halfSupport, halfSupport);
%                 if best == -1 || cost < best
%                     best = cost;
%                 end
%             end
%         end
%         map(y,x) = best;
%         count = count + 1;
%     end
% end
% end
%
% function [coords] = getImageCoords(image)
%     [rowMax, colMax] = size(image);
%     coords = zeros((rowMax * colMax), 2);
%     coordsNumber = 1;
%     for row = 1 : rowMax
%         for col = 1 : colMax
%             coords(coordsNumber,:) = [col, row];
%             coordsNumber = coordsNumber + 1;
%         end
%     end
% end

