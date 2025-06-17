function K = segmentEggs(I)
K = 255-I;

BW = imbinarize(I);

K = imbinarize(K);
K = imfill(K, "holes");

CC = bwconncomp(K,4);

L = labelmatrix(CC);
J = label2rgb(L,'jet','k','shuffle');

stats = regionprops(L, "Area");
a = vertcat(stats.Area);

statsConvexImage = regionprops(L, "ConvexImage");

egg_index = a>400;

% find the idexes of interest
egg_pixels = CC.PixelIdxList(egg_index);

statsEuler = regionprops(L, "EulerNumber");
e = cat(1, statsEuler);
e(egg_index)

M = [];

boundingBox = regionprops(L, "BoundingBox");

parasite_egg_pixels = {};

num_eggs = length(egg_pixels);

num_parasite_eggs = 0;

% analyse der Pixel in Originalbild
for i = 1:num_eggs
    % durchschnittlicher Grauwert
    if mean(I(egg_pixels{i})) < 80
        num_parasite_eggs = num_parasite_eggs + 1;
        % parasite_egg_pixels{num_parasite_eggs} = egg_pixels{i};
        
        % find edges
       
       
    end
end

for i = 1:length(egg_index)
    if egg_index(i) == 1
        B = imcrop(L, boundingBox(i).BoundingBox)
        figure;
        imshow(B);
        %convImage = cat(1, statsConvexImage(i).ConvexImage);
        %negativeConvImage = 1 - convImage;
        %figure;
        %imshow(negativeConvImage);
        %concImage = bwconvhull(negativeConvImage);
        %figure;
        %imshow(convImage);
    end
end

figure;
imshow(BW);

figure;
imshow(J);
end

