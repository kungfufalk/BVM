function [hatchedEggs, num_parasite_eggs] = countParasitedEggsAndHatched(K, I)
% create label image with high threshold for inner circles
%otsu_thresh = graythresh(K);

% high_thresh = otsu_thresh + otsu_thresh * 0.3;

BW = imbinarize(K, 0.6);

BW = imfill(BW, "holes");

CC = bwconncomp(BW,8);

L = labelmatrix(CC);

E = regionprops(L, 'all');

a = vertcat(E.Area);

% area must be greater than 20000 pixels to be counted as an parasited egg
egg_index = a>30000;

% find the pixels of interest
egg_pixels = CC.PixelIdxList(egg_index);

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
            
            if checkHatched(E(i), L, I) == 1
                hatchedEggs = hatchedEggs + 1;
            end

            % e = cat(1, E);
            % e(egg_index);   
           
        end
    % to access the correct egg index in egg_pixels
    egg_number = egg_number + 1;
    end
end

Colored = label2rgb(L,'jet','k','shuffle');

figure;
imshow(Colored);
title("Colored Labels high thresh");

figure;
imshow(BW);

end

