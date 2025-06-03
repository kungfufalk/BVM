function mittelpunkte = findMiddle(I, minWidth, lineScan_Row)
%findMiddle findet die Mittlepunkte der Gefäße über die Binarisierung des
%Bildes mit Otsu

level = graythresh(I); % binarisieren mit Otsu
BW = imbinarize(I,level);

figure;
imshow(BW);
title('Mittelpunkt erkennen');

[~, breite] = size(BW);

mittelpunkte = [];

glas = 0;

i = 1;
while i < breite % linescan von links nach rechts auf der Höhe lineScan_Row
    glasbreite = 0;
    if (i+minWidth) <= breite
        if BW(lineScan_Row, i:i+minWidth) == 1 %minimale Breite des weißen Fensters prüfen
            glas = glas + 1;
            j = 0;
            while BW(lineScan_Row, i+j+minWidth) == 1 %Breite der Flüssigkeit ermitteln für den Mittelpunkt
                j = j + 1;
                if (i+j+minWidth) > breite
                    break
                end
            end
            glasbreite = minWidth+j-1;
            halbe_glasbreite = round(glasbreite/2);
            mittelpunkte(glas) = halbe_glasbreite + i;
        end
    end
    i = i + glasbreite + 1;
end

end

