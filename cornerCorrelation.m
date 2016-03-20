function [ result ] = cornerCorrelation(image1, image2, N, supportWinSize)
	% Finds the best corner match between the two images
	% image1 the first image
	% image2 the second image
	% N the number of strongest corners to consider from the first image
	% supportWinSize the size of the support window for the correlation
	cornersL = detectHarrisFeatures(image1);
	cornersR = detectHarrisFeatures(image2);
	strongestN = cornersL.selectStrongest(N);
	pointsL = int8(strongestN.Location);
	pointsR = int8(cornersR.Location);
	
	cost = cell(N);
    [cost{:}] = deal([0,0,-1]);
	best = [0,0, -1];
	
	% For the N strongest corners in image 1 compare them to the corners in image 2 and find the best match
	for i=1:strongestN.size
		cost{i} = correlation(image1, image2, pointsL(i), pointsR, supportWinSize);
		if best(3) == -1 || best(3) > cost{i}(3)
			best = cost{i};
		end
	end
	
	result = best;
end