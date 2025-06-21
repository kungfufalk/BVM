function K = segmentEggs(I)

K = 255-I;

BW = imbinarize(I);

K = imbinarize(K);
K = imfill(K, "holes");

CC = bwconncomp(K,4);

L = labelmatrix(CC);
J = label2rgb(L,'jet','k','shuffle');

E = regionprops(L, 'all');

a = vertcat(E.Area);

% area must be greater than 400 pixels
egg_index = a>4000;

% find the pixels of interest
egg_pixels = CC.PixelIdxList(egg_index);

num_eggs = length(egg_pixels);

num_parasite_eggs = 0;

hatchedEggs = 0;

egg_number = 1;

% analyse der Pixel in Originalbild
for i = 1:length(egg_index)
    if egg_index(i) == 1
        % durchschnittlicher Grauwert
        if mean(I(egg_pixels{egg_number})) < 80
            % parasited egg is found
            num_parasite_eggs = num_parasite_eggs + 1;
      
            %compare convex figure with original figure
            C = cat(1, E(i).ConvexImage);

            B = logical(imcrop(L, E(i).BoundingBox));

            figure; imshow(C);
            figure; imshow(B);

            O = logical(K(egg_pixels{egg_number}));

            [height, width] = size(C);

            B = B(1:height, 1:width);

            diff_pic = C - B;

            figure; imshow(diff_pic);

            Components = bwconncomp(diff_pic,4);

            Labeled = labelmatrix(Components);

            diff_props = regionprops(Labeled, "All");
            
            prop_size = size(diff_props);

            for j = 1:prop_size(1)
                area = diff_props(j).Area;
                eccentricity = diff_props(j).Eccentricity;
                if area > 3000
                    hatchedEggs = hatchedEggs + 1;
                end
            end


            ColoredLabeled = label2rgb(Labeled,'jet','k','shuffle');

            figure;
            imshow(ColoredLabeled);

            % ADJUSTMENT:
            % 1. subtract the two pictures
            % 2. measure the depth of the missing pieces
            % 3. measure the area of the lagerst missing piece

            %weightedMissingArea = (sum(sum(C)) - sum(O)) / sum(O);
            %weightedMissingArea;

            e = cat(1, E);
            e(egg_index);   
           
        end
    % to access the correct egg index in egg_pixels
    egg_number = egg_number + 1;
    end
end

figure;
imshow(BW);

figure;
imshow(J);

hatchedEggs
num_parasite_eggs
num_eggs
end

