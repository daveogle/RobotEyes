function [ results ] = cornerCorrelation(image1, image2, N, supportWinSize, searchWinSize)
	% Finds the best corner match between the two images
	% image1 the first image
	% image2 the second image
	% N the number of results to return
	% supportWinSize the size of the support window for the correlation
	cornersL = detectHarrisFeatures(image1);
	cornersR = detectHarrisFeatures(image2);
	pointsL = int32(cornersL.Location);
	pointsR = int32(cornersR.Location);
    [pointsLsize,] = size(pointsL);
    range = floor(searchWinSize/ 2);
	
	cost = cell(pointsLsize);
    [cost{:}] = deal([0,0,-1]);
    results = zeros(N, 5);
	
	% For the N strongest corners in image 1 compare them to the corners in image 2 and find the best match
	for i= 1 : pointsLsize
        pointsInRange = findPointsInRange(pointsL(i,:), pointsR, range);
		cost{i} = Correlation(image1, image2, [pointsL(i,2), pointsL(i,1)], [pointsInRange(:,2),pointsInRange(:,1)], supportWinSize);
			bestR = cost{i};
            bestL = pointsL(i,:);
            match = [bestL(1), bestL(2), bestR(2), bestR(1), cost{i}(3)];
            results(i,:) = match;
        %end
    end
    results = sortrows(results,5);
    results = results(1 : N, 1 : 5);
    
    %DISPLAY FOR TEST
    figure; imshow(image1); hold on;
    for i = 1 : N
    bLc = cornerPoints(results(1 : N, 1 : 2));
    plot(bLc);
    end
    figure; imshow(image2); hold on;
    for i = 1 : N
    bRc = cornerPoints(results(1 : N, 3 : 4)); 
    plot(bRc);
    end
    
    results(:,5) = [];
end

function [ inRange ] = findPointsInRange(origin, points, range)
    [sizeX,] = size(points);
    inRange = [];
    j = 1;
    for i = 1 : sizeX
        if points(i,1) > (origin(1) - range) && points(i,1) < (origin(1) + range) ...
                && points(i,2) > (origin(2) - range) && points(i,2) < (origin(2) + range)
            inRange(j,:) = points(i,:);
            j = j + 1;
        end
    end
    if numel(inRange) == 0
        inRange = findPointsInRange(origin, points, range+5);
    end
end

function [ row ] = findRow(toFind, findIn)
    temp = ismember(findIn, toFind, 'rows');
    for i=1:numel(temp)
        if temp(i) == 1
            row = i;
        end
    end
end