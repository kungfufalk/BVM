function eggStats = extractEggAttributes(I, show)
    eggStats = [];

    K = 255-I;
    threshold = graythresh(K) * 1.125;
    BW = imbinarize(K, threshold);
    BW = imfill(BW, "holes");
    
    SE = strel("disk",9);
    BW = imerode(BW,SE);
    CC = bwconncomp(BW,8);

    L = labelmatrix(CC);

    E = regionprops(L, 'all');
    
    a = vertcat(E.Area);
    
    % area must be greater than 30000 pixels to be counted as an egg
    egg_index = a>30000;
    
    % find the pixels of interest
    egg_pixels = CC.PixelIdxList(egg_index);

    egg_number = 1;

    % analyse der Pixel in Originalbild
    for i = 1:length(egg_index)
        if egg_index(i) == 1

            eggStat.mean = 0;
            eggStat.deviation = 0;
            eggStat.missingArea = 0;
            % durchschnittlicher Grauwert
            meanVal = mean(I(egg_pixels{egg_number}));
            if meanVal < 70

                Bounding = logical(imcrop(L, E(i).BoundingBox));

                if show == 1
                    figure;
                    imshow(Bounding);
                end

                eggStat.mean = meanVal;
                
                eggStat.deviation = std2(I(E(i).PixelIdxList));
            
                Convex = cat(1, E(i).ConvexImage);
                
                [height, width] = size(Convex);
                
                % find missing parts
                diff_pic = Convex - Bounding(1:height, 1:width);
                
                Missing_Components = bwconncomp(diff_pic,8);
                
                Labeled_missing = labelmatrix(Missing_Components);
                
                diff_props = regionprops(Labeled_missing, "All");
                
                prop_size = size(diff_props);
                
                areas = vertcat(diff_props.Area);
                areas = sort(areas);
                eggStat.missingArea = areas(end);

                eggStats = [eggStats eggStat];
            end
            egg_number = egg_number + 1;
        end
    end
end

