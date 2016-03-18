function  [ windowSize ] = windowSizeCalc (baseline, focalLength, minimumDistance, dpi, scalingFactor)
% Calculates the windowSize (in pixels) for the given values and minDistance
% baseline, the distance between the cameras (in millimeters)
% focalLength, of the camera (in millimeters)
% minimumDistance, the distance to the closest object to the scene (in millimeters)
% dpi, dots per inch of the image
    windowSizeMM = (baseline * focalLength)/ minimumDistance;
    windowSize = mmToPixels(windowSizeMM, dpi) * scalingFactor;
end