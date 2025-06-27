function [hatchedEggs, num_parasite_eggs] = countParasitedEggsAndHatched(K, I)
% create label image with high threshold for inner circles
otsu_thresh = graythresh(K);

high_thresh = otsu_thresh + otsu_thresh * 0.3;

BW_high = imbinarize(K, high_thresh);

CC_high = bwconncomp(BW_high,8);

L_high = labelmatrix(CC_high);

E_high = regionprops(L_high, 'all');

a_high = vertcat(E_high.Area);

low_thresh = otsu_thresh + otsu_thresh * 0.3;

BW_low = imbinarize(K, low_thresh);

CC_low = bwconncomp(BW_low,8);

L_low = labelmatrix(CC_low);

props_low = regionprops(L_low, 'all');

% area must be greater than 20000 pixels to be counted as an parasited egg
egg_index = a_high>30000;

% find the pixels of interest
egg_pixels = CC_high.PixelIdxList(egg_index);

num_parasite_eggs = 0;

hatchedEggs = 0;

egg_number = 1;

figure;
tiledlayout;

% analyse der Pixel in Originalbild
for i = 1:length(egg_index)
    if egg_index(i) == 1
        % durchschnittlicher Grauwert
        if mean(I(egg_pixels{egg_number})) < 60
            % parasited egg is found
            num_parasite_eggs = num_parasite_eggs + 1;
            
            if checkHatched(E_high(i), props_low, L_high, I) == 1
                hatchedEggs = hatchedEggs + 1;
            end

            % e = cat(1, E);
            % e(egg_index);   
           
        end
    % to access the correct egg index in egg_pixels
    egg_number = egg_number + 1;
    end
end

% analyse der Pixel in Originalbild
for i = 1:length(egg_index)
    if egg_index(i) == 1
        % durchschnittlicher Grauwert
        if mean(I(egg_pixels{egg_number})) < 60
            % parasited egg is found
            num_parasite_eggs = num_parasite_eggs + 1;
            
            if checkHatched(E_high(i), props_low, L_high, I) == 1
                hatchedEggs = hatchedEggs + 1;
            end

            % e = cat(1, E);
            % e(egg_index);   
           
        end
    % to access the correct egg index in egg_pixels
    egg_number = egg_number + 1;
    end
end

Colored_high = label2rgb(L_high,'jet','k','shuffle');

figure;
imshow(Colored_high);
title("Colored Labels high thresh");

figure;
imshow(BW_high);

end

