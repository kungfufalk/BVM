function hatched = checkHatched(props, L, I)
%compare convex figure with original figure
    hatched = 0;    

    Bounding = logical(imcrop(L, props.BoundingBox));
    
    std2(I(props.PixelIdxList))

    if std2(I(props.PixelIdxList)) > 30
        hatched = 1;
        figure; 
        imshow(Bounding);
        title("Hatched Egg");
        return;
    end

    Convex = cat(1, props.ConvexImage);
    
    [height, width] = size(Convex);
    
    % find missing edges
    diff_pic = Convex - Bounding(1:height, 1:width);
    
    Missing_Components = bwconncomp(diff_pic,8);
    
    Labeled_missing = labelmatrix(Missing_Components);
    
    diff_props = regionprops(Labeled_missing, "All");
    
    prop_size = size(diff_props);
    
    for j = 1:prop_size(1)
        area = diff_props(j).Area;
        if area > 3500
            nexttile;
            imshow(Convex);
            title('Convex hull');
            
            nexttile;
            imshow(Bounding);
            title('Bounding box');

            nexttile
            imshow(diff_pic)
            title('Diff picture of hatched egg')

            hatched = 1;
            return;
        end
    end
end

