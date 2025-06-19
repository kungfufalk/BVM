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
egg_index = a>400;

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
            %missingArea = (sum(sum(B)) - sum(sum(C))) / length;

            % ADJUSTMENT:
            % 1. subtract the two pictures
            % 2. measure the depth of the missing pieces
            % 3. measure the area of the lagerst missing piece
            
            weightedMissingArea = (sum(sum(C)) - sum(O)) / sum(O);
            weightedMissingArea;
            if weightedMissingArea > 0.05
                hatchedEggs = hatchedEggs + 1;
            end

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
end

