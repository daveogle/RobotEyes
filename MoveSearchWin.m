function [] = MoveSearchWin(startA, startB, endA, endB, image1, image2, support_location, support_size, search_size) 
    c = startB;
    
    % loops through all rows
    while c < endB
        r = startA;
        
        %loops through all culumns for all ros
        while r < endA
            % Call method that deals with comparing the windows
            search_location = [c,r];
            PIXEL_DISP(image1, image2, support_location, support_size, search_location, search_size);
            
            r = r + 1;
        end
        c = c + 1;
    end    
end