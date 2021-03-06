function [ diff ] = SUPPORT_CMP(image1, image2, location1, location2, wsize, method)
    try
        w1 = image1((location1(1) - wsize):(location1(1) + wsize), (location1(2) - wsize):(location1(2) + wsize));
        w2 = image2((location2(1) - wsize):(location2(1) + wsize), (location2(2) - wsize):(location2(2) + wsize));
        w1 =double(w1);
        w2 = double(w2);
                
        if strcmp(method, 'SAD')
            diff = sum(abs(w1(:) - w2(:)));
        elseif strcmp(method, 'E')
            diff = sum(sqrt(w1(:) - w2(:).^2));
        else 
            diff = sum( (w1(:) - w2(:)).^2);
        end       
    catch
    end
end