function hatched = checkHatched(props_high, props_low, L_high, I)
%compare convex figure with original figure
    hatched = 0;    

    Bounding_high = logical(imcrop(L_high, props_high.BoundingBox));

    std2(I(props_low.PixelIdxList))

    if std2(I(props_low.PixelIdxList)) > 30
        hatched = 1;
        figure; 
        imshow(Bounding_high);
        title("Hatched Egg");
        return;
    end

    Convex_high = cat(1, props_high.ConvexImage);
    
    [height, width] = size(Convex_high);
    
    % find missing edges
    diff_pic = Convex_high - Bounding_high(1:height, 1:width);
    
    Missing_Components = bwconncomp(diff_pic,8);
    
    Labeled_missing = labelmatrix(Missing_Components);
    
    diff_props_high = regionprops(Labeled_missing, "All");
    
    prop_size = size(diff_props_high);
    
    for j = 1:prop_size(1)
        area = diff_props_high(j).Area;
        if area > 3000
            nexttile;
            imshow(Convex_high);
            title('Convex hull');
            
            nexttile;
            imshow(Bounding_high);
            title('Bounding box');

            nexttile
            imshow(diff_pic)
            title('Diff picture of hatched egg')

            hatched = 1;
            return;
        end
    end
end

