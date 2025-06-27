function n = countEggs(K)
% create label image with low threshold to count eggs and missing edges
otsu_thresh = graythresh(K);

low_thresh = otsu_thresh - otsu_thresh * 0.3;

BW_low = imbinarize(K, low_thresh);

BW_low_filled = imfill(BW_low, "holes");

CC_low = bwconncomp(BW_low_filled,8);

L_low = labelmatrix(CC_low);

E_low = regionprops(L_low, 'all');

a_low = vertcat(E_low.Area);

% count number of eggs in low threshold picture to find all eggs
n = sum(a_low>10000);

end

